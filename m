Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318839AbSH1Nk7>; Wed, 28 Aug 2002 09:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318841AbSH1Nk7>; Wed, 28 Aug 2002 09:40:59 -0400
Received: from pD9E23990.dip.t-dialin.net ([217.226.57.144]:36801 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318839AbSH1Nk6>; Wed, 28 Aug 2002 09:40:58 -0400
Date: Wed, 28 Aug 2002 07:45:11 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: "Stephen C. Biggs" <s.biggs@softier.com>
cc: Daniel Phillips <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched.c
In-Reply-To: <3D6BBDED.28599.4E361C@localhost>
Message-ID: <Pine.LNX.4.44.0208280744160.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 27 Aug 2002, Stephen C. Biggs wrote:
> > > > 	for (i = NR_CPUS; --i >= 0; )
> > > 
> > > 	int i = NR_CPUS;
> > > 
> > > 	while (--i)
> 
> for (i = NR_CPUS - 1; i >= 0; i--)
> 
> unless i is unsigned...

That was exactly the point, yours was the current code, and i is indeed 
unsigned.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

