Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSFBPFR>; Sun, 2 Jun 2002 11:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317195AbSFBPFQ>; Sun, 2 Jun 2002 11:05:16 -0400
Received: from pD9E239B5.dip.t-dialin.net ([217.226.57.181]:53173 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317194AbSFBPFP>; Sun, 2 Jun 2002 11:05:15 -0400
Date: Sun, 2 Jun 2002 09:05:06 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Sam Ravnborg <sam@ravnborg.org>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Thunder from the hill <thunder@ngforever.de>,
        Ion Badulescu <ionut@cs.columbia.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: KBuild 2.5 Impressions
In-Reply-To: <20020602165643.A1940@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0206020901570.29405-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Jun 2002, Sam Ravnborg wrote:
> Can we agree that it makes sense to add features one-by-one when
> they are independent?

No, as that means introducing a buggy version of kbuild-2.5 to fix the 
bugs afterwards. Sure, there are bugs, but they can be fixed either. I 
don't need to reintroduce all the kbuild-2.4 bugs therefor.

The one thing you all seem to have got wrong is that kbuild-2.5 does not 
overwrite kbuild-2.4 but exist in parallel to it. So there's nothing to 
fix, we could just introduce all the features one by one, but that means 
they all will only function after the last patch, which will be some kind 
of "activation".

For me, I don't purposely introduce bugs.

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

