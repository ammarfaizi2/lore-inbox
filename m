Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTKKQn7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 11:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbTKKQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 11:43:58 -0500
Received: from mail2-116.ewetel.de ([212.6.122.116]:42888 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S263679AbTKKQnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 11:43:53 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <QzzF.3WK.3@gated-at.bofh.it>
References: <QyWV.2Zi.1@gated-at.bofh.it> <QzzF.3WK.3@gated-at.bofh.it>
Date: Tue, 11 Nov 2003 17:43:41 +0100
Message-Id: <E1AJbcD-0000Iw-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003 06:50:07 +0100, you wrote in linux.kernel:

> As per the MO device that wants ide-scsi, send out patches to the kernel
> mailing list, and maybe the person can test it. I certainly can't test it.

Well, that person is me and I tried making it work with ide-cd. Got read
support to work, submitted to Jens, you have it in your kernel. No luck
with write support. I could get it to mount read-write and data actually
made it to disk, but umount lead to a BUG_ON. Details in:

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.0/1307.html
(the patch in there won't apply due to minor renaming of flags and the
fact that the read support part is already in your tree)

So I'm not only complaining. ;)

-- 
Ciao,
Pascal
