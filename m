Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265981AbUFXQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265981AbUFXQZT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUFXQZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 12:25:18 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:24069 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265981AbUFXQVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 12:21:19 -0400
Subject: Re: Time is running at high speed with 2.6-mm and HPET
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040624132851.GC19068@gamma.logic.tuwien.ac.at>
References: <20040624132851.GC19068@gamma.logic.tuwien.ac.at>
Content-Type: text/plain
Date: Thu, 24 Jun 2004 18:21:10 +0200
Message-Id: <1088094070.2318.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.9.2 (1.5.9.2-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 15:28 +0200, Norbert Preining wrote:
> Hi!
> 
> With 2.6-mm and 
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> my clock is running about double the speed it should. This happens with
> a laptop (acer tm 654) and my good old athlon 1400 via pc.
> 
> Turning off CONFIG_HPET_TIMER fixes the problem.
> 
> I attach my config file for 2.6.7-mm1 and the dmesg output (first lines
> are missing)

This has been fixed in 2.6.7-mm2... It seems there was a bug when APIC
was enabled.

