Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316610AbSEUUqY>; Tue, 21 May 2002 16:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSEUUp2>; Tue, 21 May 2002 16:45:28 -0400
Received: from bgp401130bgs.jersyc01.nj.comcast.net ([68.36.96.125]:8200 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id <S316615AbSEUUoR>;
	Tue, 21 May 2002 16:44:17 -0400
Date: Tue, 21 May 2002 16:44:01 -0400
Message-Id: <200205212044.g4LKi1i21931@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: "Nicholas L. D'Imperio" <dimperio@physics.dyndns.org>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Asus a7m266d stability issues
In-Reply-To: <Pine.LNX.4.33.0205211559001.737-100000@physics.dyndns.org>
User-Agent: tin/1.5.11-20020130 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 May 2002 16:07:24 -0400 (EDT), Nicholas L. D'Imperio <dimperio@physics.dyndns.org> wrote:

>> > I'm getting kernel panics using the A7m266d smp motherboard and kernel 
>> > 2.4.18 as soon as the system is put under load.
> 
> I have 1800+MP processors and my PSU is 400W.  Of course I also have the 
> little four prong connector plugged in as well.

This points very strongly towards an overheating problem. The 1800+ and 
higher CPU's run very hot. Any imperfection in the cooling setup, be 
it lack of thermal paste, undersized heatsink/fan combination, 
improperly seated heatsink, and even insufficient airflow around the
CPU's and inside the chassis, can and will cause crashes under load.

I had this exact problem a few weeks ago with a dual Athlon 1U setup. It
turned out that the aluminum heatsinks I had previously used for the
1.2GHz Athlons weren't good enough for the 1900+, and also that the
chassis fans were circulating enough air. Switching to copper heatsinks
got rid of 95% of the crashes, and adding a chassis fan got rid of the
remaining 5%.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
