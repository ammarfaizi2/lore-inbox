Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317330AbSFGTUD>; Fri, 7 Jun 2002 15:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317331AbSFGTUC>; Fri, 7 Jun 2002 15:20:02 -0400
Received: from p50886B5E.dip.t-dialin.net ([80.136.107.94]:8344 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317330AbSFGTUC>; Fri, 7 Jun 2002 15:20:02 -0400
Date: Fri, 7 Jun 2002 13:19:42 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Pavel Machek <pavel@ucw.cz>
cc: Tom Rini <trini@kernel.crashing.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup i386 <linux/init.h> abuses
In-Reply-To: <20020607110145.GA9975@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0206071318470.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Jun 2002, Pavel Machek wrote:

> Hi!
> 
> +extern void kmap_init(void);
> 
> __init is usefull as a documentation... Perhaps adding /* This is
> __init function */ would be good.

I suppose that's why it's called kmap_init(). That jumps right on me, 
biting my nose and saying "I am an init function".

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

