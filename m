Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbUAMTJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 14:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265555AbUAMTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 14:09:55 -0500
Received: from palrel11.hp.com ([156.153.255.246]:20452 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S265549AbUAMTIN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 14:08:13 -0500
Date: Tue, 13 Jan 2004 11:08:12 -0800
To: rmk@arm.linux.org.uk,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PROBLEM] ircomm ioctls
Message-ID: <20040113190812.GB10317@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20040113181034.GA9960@bougret.hpl.hp.com> <20040113182955.F7256@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040113182955.F7256@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 13, 2004 at 06:29:55PM +0000, Russell King wrote:
> On Tue, Jan 13, 2004 at 10:10:34AM -0800, Jean Tourrilhes wrote:
> > 
> > 	By the way, I would rather keep the function
> > ircomm_tty_tiocmget() and ircomm_tty_tiocmset() in ircomm_tty_ioctl.c,
> > because ircomm_tty.c is already big and messy.
> > 	Check the patch below (quickly tested).
> 
> I think this patch is missing some of the error checking (TTY_IO_ERROR)
> which I included in my later patch.

	Oh well... I probably missed your subsequent patch. Sorry
about that.
	I used this patch of yours :
http://marc.theaimsgroup.com/?l=linux-kernel&m=107399412221312&w=2

> Russell King

	Thanks, and have fun...

	Jean
