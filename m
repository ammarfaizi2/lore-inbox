Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVCMLxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVCMLxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVCMLxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:53:09 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:23825 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S261157AbVCMLxF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:53:05 -0500
To: Junfeng Yang <yjf@stanford.edu>
Cc: Andrew Morton <akpm@osdl.org>, <chaffee@bmrc.berkeley.edu>,
       <mc@cs.Stanford.EDU>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] crash + fsck cause file systems to contain loops
 (msdos and vfat, 2.6.11)
References: <Pine.GSO.4.44.0503122146410.4831-100000@elaine24.Stanford.EDU>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sun, 13 Mar 2005 20:52:41 +0900
In-Reply-To: <Pine.GSO.4.44.0503122146410.4831-100000@elaine24.Stanford.EDU> (Junfeng
 Yang's message of "Sat, 12 Mar 2005 21:53:54 -0800 (PST)")
Message-ID: <87k6ob4vau.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang <yjf@stanford.edu> writes:

> I'm using dosfsck 2.10, 22 Sep 2003, FAT32, LFN, and yes,
> I do see root directory after I run dosfsck on the crashed disk
> image.

You can download fixed version of dosfsck at

  http://user.parknet.co.jp/hirofumi/tmp/fatfsprogs.tar.bz2

(vanilla dosfsck-2.10 doesn't fix this corruption.)

> I'm checking 2.6.11.  By "your testing tree didn't have my
> patches yet", you mean you have the patch but haven't made it
> public?

No. My patches was merged to linus tree at 2 or 3 days ago (merged
after 2.6.11 release).  So, I guessed your tree didn't have my patches
yet.

> This "testing tree" is the Linux source tree? 

Yes.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
