Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265031AbUEYSpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265031AbUEYSpQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbUEYSpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:45:15 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:13572 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265031AbUEYSpN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:45:13 -0400
Subject: Re: System clock running too fast
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Michael Buesch <mbuesch@freenet.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200405251939.47165.mbuesch@freenet.de>
References: <200405251939.47165.mbuesch@freenet.de>
Content-Type: text/plain
Message-Id: <1085510708.1689.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Tue, 25 May 2004 20:45:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 19:39, Michael Buesch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I've got the problem with my server, that the system-clock
> is running really fast. It's running over one second too
> fast in one hour (aproximately).

Have you tried enabling CONFIG_HPET_TIMER *or* CONFIG_X86_PM_TIMER to
see if it helps? They support high accuracy timers.

