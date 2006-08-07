Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWHGSHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWHGSHx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWHGSHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:07:53 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:45250 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932251AbWHGSHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:07:52 -0400
Date: Mon, 7 Aug 2006 19:55:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: greg@enjellic.com
cc: Theodore Tso <tytso@mit.edu>, Adrian Ulrich <reiser4@blinkenlights.ch>,
       vonbrand@inf.utfsm.cl, ipso@snappymail.ca, reiser@namesys.com,
       lkml@lpbproductions.com, jeff@garzik.org, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
In-Reply-To: <200608071737.k77Hbjph002429@wind.enjellic.com>
Message-ID: <Pine.LNX.4.61.0608071954560.3365@yvahk01.tjqt.qr>
References: <200608071737.k77Hbjph002429@wind.enjellic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> With the latest e2fsprogs and 2.6 kernels, the online resizing
>> support has been merged in, and as long as the filesystem was
>> created with space reserved for growing the filesystem (which is now
>> the default, or if the filesystem has the off-line prepration step
>> ext2prepare run on it), you can run resize2fs on a mounted
>> filesystem and grow an ext2/3 filesystem on-line.  And yes, you get
>> more inodes as you add more disk blocks, using the original inode
>> ratio that was established when the filesystem was created.
>
>Are all the necessary tools in and documented in e2fsprogs?
>
>It seems that finding all the bits and pieces to do ext3 on-line
>expansion has been a study in obfuscation.  Somewhat surprising since
>this feature is a must for enterprise class storage management.

Enterprise will hardly use ext3 on the big ones, but one of the "more
commercial" things.



Jan Engelhardt
-- 
