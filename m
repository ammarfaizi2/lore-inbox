Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317348AbSFCKNr>; Mon, 3 Jun 2002 06:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317350AbSFCKNq>; Mon, 3 Jun 2002 06:13:46 -0400
Received: from dsl-213-023-039-253.arcor-ip.net ([213.23.39.253]:43935 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317348AbSFCKNN>;
	Mon, 3 Jun 2002 06:13:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Keith Owens <kaos@ocs.com.au>, Paul P Komkoff Jr <i@stingr.net>
Subject: Re: [ANNOUNCE] kbuild 2.5 ports for -pre9 and -pre9-ac1
Date: Mon, 3 Jun 2002 12:12:10 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <31456.1023084181@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Eoot-0000sG-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 June 2002 08:03, Keith Owens wrote:
> On Thu, 30 May 2002 23:55:44 +0400, 
> Paul P Komkoff Jr <i@stingr.net> wrote:
> >I'm here to announce updates of kbuild 2.5 patch to apply on 2.4.19-pre9 and
> >2.4.19-pre9-ac1
> 
> Thanks for this, it shows that other people can do kbuild 2.5 work.
> 
> However there are no plans to replace the kernel build method in 2.4
> kernels, it is too big a change for a stable kernel.  I have already
> extracted several bugs fixes from kbuild 2.5 and fed them to Marcelo or
> Alan Cox.

However, for folks like me who develop mainly on the 2.4 kernel this
is a real blessing, and I hope Paul continues to maintain this.

> There is a limited amount that can be fixed in the 2.4 kernel build
> without a large impact on users.  Anything that forces an upgrade past
> make 3.77.1 (the currently required version on 2.4 kernels) is
> unacceptable.

<checks make version>

Oh, I've got 3.79.1, there ya go, I guess that's why it works.  Thanks
once again, debian gnomes.  Anyway, there's not a lot to fear since
the patch has no apparent ill effect on the operation of old kbuild.
I'm not advocating that Marcelo merge it just yet, no rush.  It
obviously needs to mature in 2.5 first.

-- 
Daniel
