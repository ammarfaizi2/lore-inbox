Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSIJVbh>; Tue, 10 Sep 2002 17:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318158AbSIJVbh>; Tue, 10 Sep 2002 17:31:37 -0400
Received: from dsl092-148-080.wdc1.dsl.speakeasy.net ([66.92.148.80]:40429
	"EHLO tyan.doghouse.com") by vger.kernel.org with ESMTP
	id <S318152AbSIJVbg>; Tue, 10 Sep 2002 17:31:36 -0400
Date: Tue, 10 Sep 2002 17:36:21 -0400 (EDT)
From: Maxwell Spangler <maxwax@speakeasy.net>
X-X-Sender: <maxwell@tyan.doghouse.com>
To: Adam Jaskiewicz <adamjaskie@yahoo.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Western Digital hard drive and DMA
In-Reply-To: <02090816463707.00459@aragorn>
Message-ID: <Pine.LNX.4.33.0209101730480.31550-100000@tyan.doghouse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Adam Jaskiewicz wrote:

> OK, I have heard that other people have been having this problem for a while 
> now, but I havent been able to find much about what causes it. I have a 
> Western Digital hard drive in my computer (60GB, 5400 RPM) I can use it just 
> fine with no DMA, but it runs much faster with DMA. However, when I use DMA, 
> all my data is slowly corrupted, and I begin having to re-install packages 
> all the time. After about a month, my system deteriorates to the point where 
> I have to reinstall slackware. I have no idea why this is happening, but I 
> know some people who have had the same experience under Linux with Western 
> Digital hard drives, but not with other brands. I am assuming this is a 
> problem with Western Digital's implimentation of DMA, but shouldnt it do 
> something to prevent errors?

This _could_ be your power supply.

I had problems with two IBM 22GXP drives attached to a Tyan dual slot1 board 
based on the BX chipset.  The system seemed fine other than drives would spin 
down and spin up occasionally and the /var/log/messages output would indicate 
DMA "drive not ready" errors.

I can't remember why I finally did it, but after replacing the power supply, 
the system operated fine.  The original was 3 years old, a generic to begin 
with.  (I've become a big fan of Antec power supplies and cases now that I've 
upgraded to Athlon class CPUs.)

Andre's drivers (which your output shows you are using on 2.4.17) have been 
very good on this type of equipment, IMHO.  But software can't overcome 
failing or poor quality hardware and the age of the BX chipset suggests this 
is probably and older computer as well.

This is just a guess, but something you can try and investigate on your own 
right now..

-- ----------------------------------------------------------------------------
Maxwell Spangler                                                
Program Writer                                              
Greenbelt, Maryland, U.S.A.                         
Washington D.C. Metropolitan Area 

