Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbULGSOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbULGSOk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 13:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbULGSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 13:14:40 -0500
Received: from ctb-mesg4.saix.net ([196.25.240.76]:49830 "EHLO
	ctb-mesg4.saix.net") by vger.kernel.org with ESMTP id S261872AbULGSOh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 13:14:37 -0500
From: "Niel Lambrechts" <antispam@telkomsa.net>
To: <linux-kernel@vger.kernel.org>
Subject: RE: kernel panic after changing processor arch
Date: Tue, 7 Dec 2004 20:14:30 +0200
Message-ID: <000901c4dc88$99079350$0a00000a@MERCKX>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: 
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am trying to recompile using processor architecture 
> PENTIUMM instead of i586/i686.
> 
> Mkinitrd is used to create an initial ramdisk, but upon reboot I get:
> 
> reiserfs: version magic '2.6.8-24.5-default PENTIUMM REGPARM 
> gcc-3.3' should be '2.6.8-24.5-default 586 REGPARM gcc-3.3'
> insmod: error inserting 
> '/lib/modules/2.6.8-24.5-default/kernel/fs/reiserfs/reiserfs.k
> o': -1 invalid module format Waiting for device /dev/hda3 to 
> appear: ok
> rootfs: major=3 minor=3 devn=771
> Kernel panic - not syncing: VFS: Unable to mount root fs on 
> unknown-block(3,3)

Problem caused by user error.
lilo.conf boot stanza for the new image was pointing to the wrong kernel
in /boot...

Difficult to spot since the erroneous entry had the same kernel version.
(lame excuse). besides. I was tired.

~ Niel

