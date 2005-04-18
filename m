Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262007AbVDRJ7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbVDRJ7J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbVDRJ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:59:09 -0400
Received: from mail.dif.dk ([193.138.115.101]:31433 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262007AbVDRJ7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:59:04 -0400
Date: Mon, 18 Apr 2005 11:57:34 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: S S <singsys@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernelpanic - not syncing: VFS: Unable to mount root fs on
 unknown-block
In-Reply-To: <20050418005525.7250.qmail@web60119.mail.yahoo.com>
Message-ID: <Pine.LNX.4.62.0504181155570.2522@dragon.hyggekrogen.localhost>
References: <20050418005525.7250.qmail@web60119.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Apr 2005, S S wrote:

> I compiled linux kernel 2.6.11.7 on RHEL and while
> rebooting I get this
> error message -
> 
> Cannot open root device /SCSIGroup00/SCSIVol000
> Please append a correct "root=" boot option
> Kernelpanic - not syncing: VFS: Unable to mount root
> fs on
> unknown-block 0,0
> 
> This root entry in grub .conf is identical to kernel
> image entry 2.6.9 which boots fine. However 2.6.11.7
> compiled kernel does not find
> /dev//SCSIGroup00/SCSIVol000
> 
> Could anyone please suggest what could be going wrong.
> 
Perhaps you forgot to build in support for your SCSI controller?  That 
could explain it.  Or maybe you forgot to include support for the 
filesystem used on the / partition?  That could also explain it.


-- 
Jesper Juhl



