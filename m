Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265200AbUA2Kob (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265376AbUA2Kob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:44:31 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24498 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265200AbUA2Ko3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:44:29 -0500
Date: Thu, 29 Jan 2004 11:44:25 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc in BK: Oops loading parport_pc.
Message-ID: <20040129104425.GA8619@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040125115129.GA10387@merlin.emma.line.org> <20040125151454.70b5011e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040125151454.70b5011e.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jan 2004, Andrew Morton wrote:

> There is one known problem in this area: unloading 8250_pnp will wreck the
> kobject tree.  Try
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm3/broken-out/8250_pnp-cleanup.patch

Works for me. Thank you.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
