Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUA0B2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbUA0B2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:28:09 -0500
Received: from wilma.widomaker.com ([204.17.220.5]:3342 "EHLO
	wilma.widomaker.com") by vger.kernel.org with ESMTP id S263310AbUA0B2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:28:03 -0500
Date: Mon, 26 Jan 2004 19:59:48 -0500
From: Charles Shannon Hendrix <shannon@widomaker.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6.1 and cdrecord on ATAPI bus
Message-ID: <20040127005947.GH18905@widomaker.com>
References: <20040117031925.GA26477@widomaker.com> <4014789F.2000202@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4014789F.2000202@tmr.com>
X-Message-Flag: Microsoft Loves You!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, 25 Jan 2004 @ 21:17 -0500, Bill Davidsen said:

> I believe that you will find that you have to compile for 2.6 on a 
> machine with /usr/src/linux pointing to the 2.6 kernel source. This is 
> being discussed elsewhere, but is what got things working for me.

That should not matter any more.

For what it is worth, the problem appears to be fixed, and in the
wierdest way.

I booted kernel 2.4 without ide-scsi, and it failed to work.  Then I
booted 2.4 with ide-scsi, and things were working again.

The burner could not read the last three CDs I burned, one CD/RW, and
the other CD/R's on kernel 2.6.1 and the other on a Windows machine.

Just for the hell of it, I blanked and burned the CD/RW.

Instantly, I could read all of the "problem" CDs.

I booted 2.4 without ide-scsi, and it worked.

I booted 2.6.1 without ide-scsi, and it worked.

It's as if doing that blank and burn operation "fixed" something about
the drive.

I'm hoping to try a few reboots to make sure this drive is working
before fully deciding things are OK, but it certainly looks that way.



-- 
shannon "AT" widomaker.com -- ["If you tell the truth, you don't have to
remember anything" -- Mark Twain]
