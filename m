Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318289AbSHPKpo>; Fri, 16 Aug 2002 06:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSHPKpo>; Fri, 16 Aug 2002 06:45:44 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:10644 "EHLO
	gatekeeper.slim") by vger.kernel.org with ESMTP id <S318289AbSHPKpo>;
	Fri, 16 Aug 2002 06:45:44 -0400
Subject: Re: sound choking with trident driver (SiS 7018)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020815121602.GI6772@alhambra.actcom.co.il>
References: <1029409909.1121.17.camel@paragon.slim> 
	<20020815121602.GI6772@alhambra.actcom.co.il>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-2) 
Date: 16 Aug 2002 12:54:03 +0200
Message-Id: <1029495244.1294.2.camel@paragon.slim>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just tried the driver from 2.4.20pre2. No change in behavior. The
sound still chokes every few seconds. Any ideas what might cause this
problem? It doesn't have to be the sound driver.

I will give 2.5 another go. 


On Thu, 2002-08-15 at 14:16, Muli Ben-Yehuda wrote:
    On Thu, Aug 15, 2002 at 01:11:49PM +0200, Jurgen Kramer wrote:
    > Hi,
    > 
    > I have a laptop with a SiS 7018 soundchip. While playing music
    > the sound chokes every few seconds (2.4.19 kernel). I am not sure where
    > the problem lies. With the ALSA drivers under kernel 2.5 the problem is
    > not there.
    > 
    > Is there a newer driver for the SiS 7018 (trident.c). The current driver
    > in 2.4 is dated October 2001.
    
    the -ac tree and 2.4.20-pre1 and onwards (as well as 2.5) contain an
    updated trident.c driver. I don't see anything there that is obviously
    related to your problems, but you might wish to give the updated
    driver a try anyway.  
    
    Thanks and please let us know how it goes, 
    -- 
    "Hmm.. Cache shrink failed - time to kill something?
     Mhwahahhaha! This is the part I really like. Giggle."
    					 -- linux/mm/vmscan.c
    http://vipe.technion.ac.il/~mulix/	http://syscalltrack.sf.net
    
    

