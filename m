Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313087AbSELNEX>; Sun, 12 May 2002 09:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313128AbSELNEW>; Sun, 12 May 2002 09:04:22 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:19716 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S313118AbSELNEV>; Sun, 12 May 2002 09:04:21 -0400
Date: Sun, 12 May 2002 15:04:01 +0200 (CEST)
From: Pawel Kot <pkot@linuxnews.pl>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19pre8-ac2
In-Reply-To: <20020512125151.GD3749@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.33.0205121501190.493-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 May 2002, Tomas Szepe wrote:

> > [Alan Cox <alan@redhat.com>, May-11 2002, Sat, 19:47 -0400]
> >
> > Linux 2.4.19pre8-ac2
>
> Alan, do you suppose you could integrate the new backported NTFS code in
> -ac at some not-so-distant point in time? I reckon that would be a generally
> appreciated decision, as demand of decent NTFS access has existed for
> quite a bit of time already and 2.6 will yet take a while to land.

Current version (2.0.7a) of the backported NTFS will not work with -ac
kernels with preemption enabled. I just finished adding preemption patch
for it and hopefully after (successful) tests will release 2.0.7b.

I think I can provide a patch against the recent -ac patch as well.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

