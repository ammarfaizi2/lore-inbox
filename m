Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSE3MEo>; Thu, 30 May 2002 08:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSE3MEn>; Thu, 30 May 2002 08:04:43 -0400
Received: from spook.vger.org ([213.204.128.210]:35052 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S316342AbSE3MEk>; Thu, 30 May 2002 08:04:40 -0400
Date: Thu, 30 May 2002 14:42:02 +0200 (CEST)
From: me@vger.org
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Strange RAID2 behavier...
In-Reply-To: <15606.5268.471724.793301@notabene.cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.21.0205301441000.20123-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 May 2002, Neil Brown wrote:

> On Thursday May 30, me@vger.org wrote:
> > 
> > # raidstop --all /dev/md3
> > /dev/md3: Device or resource busy
> 
> This just means that /dev/md3 is busy.
> Is it mounted?  Does any process have it open?
> 

md3 is unmounted and not in use by anything.

> There is a bug in one version of raidtools that causes raidstop to
> incorrectly report this error, but I think that bug only affects
> /dev/md0..
> What does
>    strace raidstop /dev/md3
> show?
> 

cant do that now =) because ive already "fixed" the problem (read my other
mails).



