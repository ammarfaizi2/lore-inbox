Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129485AbQKVH6w>; Wed, 22 Nov 2000 02:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129868AbQKVH6d>; Wed, 22 Nov 2000 02:58:33 -0500
Received: from slc389.modem.xmission.com ([166.70.2.135]:29451 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129485AbQKVH6b>; Wed, 22 Nov 2000 02:58:31 -0500
To: Aaron Sethman <androsyn@ratbox.org>
Cc: Roberto Fichera <kernel@tekno-soft.it>,
        Jakob Xstergaard <jakob@unthought.net>, linux-kernel@vger.kernel.org
Subject: Re: Ext2 & Performances
In-Reply-To: <Pine.LNX.4.21.0011211334530.1902-100000@squeaker.ratbox.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Nov 2000 22:41:53 -0700
In-Reply-To: Aaron Sethman's message of "Tue, 21 Nov 2000 13:36:55 -0500 (EST)"
Message-ID: <m1g0kk36n2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aaron Sethman <androsyn@ratbox.org> writes:

> You might want to take a look at using reiserfs on the 130GB partition, as
> its is journalled and doesn't need to be fsck'ed.  
No.

All journaling filesystems need to be fsck'ed.
A correctly operating one simply doesn't need to be fsck'ed  because
of unexpected loss of operating system.    Which brings greatly reduce
the probability.  If an error is detected in the filesystem fsck is
still what you have to do to correct it.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
