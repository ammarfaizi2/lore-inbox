Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264846AbRGSCju>; Wed, 18 Jul 2001 22:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRGSCjj>; Wed, 18 Jul 2001 22:39:39 -0400
Received: from gatekeeper.zeitgeist.com ([204.243.76.2]:50917 "EHLO
	charon.ny.zeitgeist.com") by vger.kernel.org with ESMTP
	id <S264846AbRGSCjd>; Wed, 18 Jul 2001 22:39:33 -0400
Message-Id: <200107190239.f6J2dNU01537@thx1138.ny.zeitgeist.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: "Michael Stiller" <michael@toyland.ping.de>, linux-kernel@vger.kernel.org
Subject: Re: PCI hiccup installing Lucent/Orinoco carbus PCI adapter 
In-Reply-To: Your message of "18 Jul 2001 08:56:06 +0200."
             <20010718065606.1125.qmail@toyland.ping.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Jul 2001 22:39:23 -0400
From: David HM Spector <spector@zeitgeist.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael,

It was very hard to get the info on whether or not the BIOS was allocating an 
INT for the Orinoco PCI cardbus because it flies by so damned fast.  
However, after (literally) taking a picture of the screen with a digital 
camera (oy!!) I was able to determine that the BIOS is NOT allocating an 
INT for this card.  

Everything else is in the box seems to be allocated properly.  I even removed 
all but the video card just to make sure that it wasn't a resource constraint 
problem... 

My next step is to get 2.4.6 up to see if that patch fixes it, but my machine 
keeps hanging up just after activating the swap space.  Haven't figured that 
one out yet, but I think it mught be a large memory problem as my
machine has 1GB of main memory.

_DHMS

-- 
--------------------------------------------------------------------------------
David HM Spector                        Network Design & Infrastructure Security
spector@zeitgeist.com               -or-                     spector@spector.com
Amateur Radio: W2DHM (ARRL life member) GridSquare: FN30hv (40.52'45"N 73.21'21"W) 
-.-. --- -. -. . -.-. -  .-- .. - ....  .- -- .- - . ..- .-.  .-. .- -.. .. ---
Those who will not reason, are bigots, those who cannot, are fools, and those who 
dare not, are slaves.     -George Gordon Noel Byron [a.k.a Lord Byron](1788-1824)





