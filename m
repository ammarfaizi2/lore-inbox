Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293545AbSBZIxV>; Tue, 26 Feb 2002 03:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293546AbSBZIxM>; Tue, 26 Feb 2002 03:53:12 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:16392 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S293545AbSBZIwz>; Tue, 26 Feb 2002 03:52:55 -0500
Date: Tue, 26 Feb 2002 09:52:53 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: HZ value used in kernel/acct.c
In-Reply-To: <20020225214437.C10218@ragnar-hojland.com>
Message-ID: <Pine.LNX.4.33.0202260945550.11676-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Ragnar Hojland Espinosa wrote:
> On Sun, Feb 24, 2002 at 10:35:33PM +0100, Tim Schmielau wrote:
> > What is the supposed unit of the ac_etime field of struct acct?
[...]
> 
> The acct.c implementation followed FreeBSD's which also expressed comp_t
> in terms platform dependant 1/(A)HZ   You could check the "[Patch] fix
> incorrect jiffies compares" thread for a fix on uptime and 64 bit jiffies
> someone sent.. didn't pay attention in why it didn't get in, tho.
> 
Actually it was me who started the thread :-)
The question arose when I went over the patch to do a final version for 
submission to Marcelo and noticed that the 32bit values would overflow on 
alpha after 48.5 days even with my patch.

However, there seems to be so little response that I will probably just 
leave it the way it is now.

Tim

