Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272445AbRH3Utz>; Thu, 30 Aug 2001 16:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272446AbRH3Utp>; Thu, 30 Aug 2001 16:49:45 -0400
Received: from d-dialin-2885.addcom.de ([213.61.82.5]:55534 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S272445AbRH3Uti>; Thu, 30 Aug 2001 16:49:38 -0400
Date: Thu, 30 Aug 2001 22:49:24 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Erik Tews <erik.tews@gmx.net>
cc: Alan Cox <laughing@shared-source.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.9-ac4
In-Reply-To: <20010830181856.A6691@no-maam.dyndns.org>
Message-ID: <Pine.LNX.4.33.0108302130420.4426-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Erik Tews wrote:

> On Thu, Aug 30, 2001 at 03:46:37PM +0100, Alan Cox wrote:
> > 2.4.9-ac4
> > o	Fix X.75 with new hisax drivers and an isdn	(Kai Germaschewski)
> > 	disconnect race
> 
> What is that exactly? I got the problem that mppp is not working
> correctly with 2.4.9 and 2.4.10-pre2 (and I tried some 2.4.9-ac too).

These fixes only affect the new ST5481 USB driver.

> When I came to my router, I had the following lines on my console
> 
> isdn_ppp_mp_receive: lpq->ppp_slot -1
> isdn_ppp_mp_receive: lpq->ppp_slot -1
> isdn_ppp_mp_receive: lpq->ppp_slot -1
> isdn_ppp_mp_receive: lpq->ppp_slot -1
> isdn_ppp_xmit: lp->ppp_slot -1

MPPP is still buggy, and unfortunately nobody seems to have the time to 
fix it - probably because it seems easier to rewrite it than to fix the 
mess.

--Kai


