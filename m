Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265502AbUA2K4b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 05:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265652AbUA2K4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 05:56:30 -0500
Received: from 213-84-216-119.adsl.xs4all.nl ([213.84.216.119]:51594 "EHLO
	morannon.frodo.local") by vger.kernel.org with ESMTP
	id S265502AbUA2K43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 05:56:29 -0500
From: Frodo Looijaard <frodol@dds.nl>
Date: Thu, 29 Jan 2004 11:56:24 +0100
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH to access old-style FAT fs
Message-ID: <20040129105624.GA1072@frodo.local>
References: <20040126173949.GA788@frodo.local> <bv3qb3$4lh$1@terminus.zytor.com> <87n0898sah.fsf@devron.myhome.or.jp> <4016B316.4060304@zytor.com> <87ad4987ti.fsf@devron.myhome.or.jp> <20040128115655.GA696@arda.frodo.local> <87y8rr7s5b.fsf@devron.myhome.or.jp> <20040128202443.GA9246@frodo.local> <87bron7ppd.fsf@devron.myhome.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bron7ppd.fsf@devron.myhome.or.jp>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have run a small test in MS-DOS 5.00:

  1) Create a new directory
  2) Create five files in it
  3) Change the first character of the second filename to 0x00 with an editor
  4) Do a DIR listing: only one file is seen
     Linux shows four files!
  5) Create a new file
  6) Do a DIR listing: there are five files

So MS-DOS 5.00 at least does stop when a 0x00 marker is found, but does
not write new 0x00 markers when a 0x00 marker is overwritten. 

Thanks,
  Frodo

-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.
