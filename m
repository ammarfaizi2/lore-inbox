Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317209AbSFLReQ>; Wed, 12 Jun 2002 13:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317747AbSFLReP>; Wed, 12 Jun 2002 13:34:15 -0400
Received: from mail.parknet.co.jp ([210.134.213.6]:21771 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S317209AbSFLReO>; Wed, 12 Jun 2002 13:34:14 -0400
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Alan <alan@clueserver.org>, linux-kernel@vger.kernel.org,
        "Witek Krecicki" <adasi@kernel.pl>
Subject: Re: Status of FAT CVF?
In-Reply-To: <1023856708.2934.9.camel@summanulla.clueserver.org>
	<20020612065417.GE30507@clusterfs.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 13 Jun 2002 02:32:52 +0900
Message-ID: <87it4ocshn.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> On Jun 11, 2002  21:38 -0700, Alan wrote:
> > What is the status of fat_cvf in 2.4.x?  Is the code abandoned?
> > Supported? Working? Not working? Pining for the fnords?
> > 
> > I have an old drive I am trying to get data off of and mounting the
> > compressed partition via loopback does something strange.  The mount
> > point shows no files, but "df" shows the correct amount for data used. 
> > (The compressed DriveSpace 3.x partition does contain data.)
> > 
> > Not urgent.  (I can get the data other ways.)  Just wanting to know how
> > bad it is before I start wading into the code.
> 
> There was a patch posted last week to l-k which basically removed CVF
> support from the kernel entirely, because it was totally non-functional.

I got direct email about it. Then he said, he ports and uses dmsdos on
2.4. And I asked if he can port dmsdos to 2.5 or not. So, currently
that patch is pending.

Witek, can you post a patch of dmsdos for 2.4?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
