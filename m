Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317257AbSHJTEQ>; Sat, 10 Aug 2002 15:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317264AbSHJTEQ>; Sat, 10 Aug 2002 15:04:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63247 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317257AbSHJTEP>;
	Sat, 10 Aug 2002 15:04:15 -0400
Message-ID: <3D5566DB.22EB0BA4@zip.com.au>
Date: Sat, 10 Aug 2002 12:17:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: lkml <linux-kernel@vger.kernel.org>, reiserfs-dev@namesys.com
Subject: Re: [patch 7/12] use atomic kmaps in generic_file_write
References: <3D5464E8.28CA1AF4@zip.com.au> <20020810170756.A975@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
> On Fri, Aug 09, 2002 at 05:57:12PM -0700, Andrew Morton wrote:
> 
> > I made a bit of a mess of reiserfs.  It works OK, but I suspect it's
> > performing unnecessary kmaps.
> 
> We have reviewed the fs/reiserfs/inode.c change you proposed and we think
> that patch below should be applied instead of it.

OK, thanks - shall do.

> Unfortunatelly we were not able to test it as 2.5.30 + your patches
> locks up even before it have a chance to go to login prompt (and to even
> touch reiserfs code, since I was booting off ext2 partition).

That's strange - that code has been under test by myself and
several others for a week or two.
