Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316187AbSETSYg>; Mon, 20 May 2002 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316189AbSETSYf>; Mon, 20 May 2002 14:24:35 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65030 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S316187AbSETSYf>; Mon, 20 May 2002 14:24:35 -0400
Date: Mon, 20 May 2002 14:19:48 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Miquel van Smoorenburg <miquels@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: IO stats in /proc/partitions
In-Reply-To: <E17899v-0003Cl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020520141820.29156A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002, Alan Cox wrote:

> > Perhaps, but I had the opposite experience. I noticed by accident
> > that iostat (as included in Debian) suddenly had working extended
> > statistics. So there are *certainly* tools that get fixed by
> > 2.4.19-pre7. I was pleasantly surprised.
> 
> Pretty much every vendor shipped the /proc/partitions changes and
> has tools that will look for them. Its annoying to change stuff but
> long term /proc/partitions is the wrong place for disk stats

  Changes belong in 2.5, /proc/partitions is the wrong place, but it's
also the place the tools expect. I hope that's not going to change in the
stable kernel.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

