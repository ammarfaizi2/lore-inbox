Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314829AbSFIT74>; Sun, 9 Jun 2002 15:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314929AbSFIT7z>; Sun, 9 Jun 2002 15:59:55 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:53255 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S314829AbSFIT7y>; Sun, 9 Jun 2002 15:59:54 -0400
To: F ker <f_ker@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] vfat doesn't support files > 2GB under Linux, under Windoze it does
In-Reply-To: <20020609180051.39760.qmail@web14606.mail.yahoo.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Mon, 10 Jun 2002 04:59:46 +0900
Message-ID: <87fzzwdxzh.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

F ker <f_ker@yahoo.co.uk> writes:

> > > Could someone direct me towards a patch?  Many thanks.
> > 
> > This patch is for 2.5.19, but, the back porting to 2.5.18 should
                                                       ^^^^^^
Grr. I didn't notice typo.                             2.4.18

> > be not difficult.
> 
> hmm... so 2.4 series won't be getting it then?  I'm not a kernel
> hacker as such, so I can't do it myself.

This patch break some filesystems (adfs, affs, hfs, hpfs, qnx4).
And I haven't fixed them yet. So, I can't submit this patch.

If it's OK, I'll make the patch for 2.4.18.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
