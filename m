Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263244AbRFFORY>; Wed, 6 Jun 2001 10:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263292AbRFFORF>; Wed, 6 Jun 2001 10:17:05 -0400
Received: from stanis.onastick.net ([207.96.1.49]:6919 "EHLO
	stanis.onastick.net") by vger.kernel.org with ESMTP
	id <S263244AbRFFOQx>; Wed, 6 Jun 2001 10:16:53 -0400
Date: Wed, 6 Jun 2001 10:16:51 -0400
From: Disconnect <lkml@sigkill.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606101651.A852@sigkill.net>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010605231908.A10520@illusionary.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Jun 2001, Derek Glidden did have cause to say:

> > The swapoff algorithms in 2.2 and 2.4 are basically identical.
> > The problem *appears* worse in 2.4 because it uses lots
> > more swap.
> 
> I disagree with the terminology you're using.  It *is* worse in 2.4,
> period.  If it only *appears* worse, then if I encounter a situation
> where a 2.2 box has utilized as much swap as a 2.4 box, I should see the
> same results.  Yet this happens not to be the case. 

Ditto here - my box (1.2g tbird, 512M ram, 128M+128M swap, mixed scsi/ide)
does the same on swapoff -- 2.2.16 can be 100 megs or more into swap, and
it gets sluggish for a bit and then is fine.  2.4.[123] can be only 10
megs into swap and it basically hardlocks for about 5-10 minutes.

---

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1 [www.ebb.org/ungeek]
GIT/CC/CM/AT d--(-)@ s+:-- a-->? C++++$ ULBS*++++$ P- L+++>+++++ 
E--- W+++ N+@ o+>$ K? w--->+++++ O- M V-- PS+() PE Y+@ PGP++() t
5--- X-- R tv+@ b++++>$ DI++++ D++(+++) G++ e* h(-)* r++ y++
------END GEEK CODE BLOCK------
