Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262053AbSJDP2s>; Fri, 4 Oct 2002 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262054AbSJDP2s>; Fri, 4 Oct 2002 11:28:48 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:57352 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S262053AbSJDP2r>; Fri, 4 Oct 2002 11:28:47 -0400
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Scott Bronson <bronson@rinspin.com>, <linux-kernel@vger.kernel.org>
Subject: Re: FAT/VFAT and the sync flag
References: <Pine.LNX.4.33L2.0210032215020.18964-100000@dragon.pdx.osdl.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 05 Oct 2002 00:33:50 +0900
In-Reply-To: <Pine.LNX.4.33L2.0210032215020.18964-100000@dragon.pdx.osdl.net>
Message-ID: <87d6qq1an5.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> On 3 Oct 2002, Scott Bronson wrote:
> 
> | Can anyone tell me if the VFAT filesystem actually recognizes the sync
> | flag?  Early in 2.4, it appeared that it was ignoring it.
> |
> | However, now that a lot of USB devices are VFAT, this gets pretty
> | important.
> 
> Now, for you first question, I hope that Ogawa or Al or Christoph
> et al can answer it, but my guess is, No, VFAT doesn't
> recognize the sync flag.  I base that on grepping for
> s_sync and for MS_SYNCHRONOUS in linux/fs/{fat,vfat,msdos}
> and finding s_sync a few times, but not finding MS_SYNCHRONOUS
> at all.

You are right. The fatfs just ignore the sync flag.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
