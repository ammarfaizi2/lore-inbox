Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319056AbSIJHBS>; Tue, 10 Sep 2002 03:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSIJHBS>; Tue, 10 Sep 2002 03:01:18 -0400
Received: from khms.westfalen.de ([62.153.201.243]:24269 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S319056AbSIJHBR>; Tue, 10 Sep 2002 03:01:17 -0400
Date: 10 Sep 2002 08:48:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8WbPE$Fmw-B@khms.westfalen.de>
In-Reply-To: <E17oUzP-0006tu-00@starship>
Subject: Re: Question about pseudo filesystems
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20020909204834.A5243@kushida.apsleyroad.org> <20020907192736.A22492@kushida.apsleyroad.org> <E17o4UE-0006Zh-00@starship> <20020909204834.A5243@kushida.apsleyroad.org> <E17oUzP-0006tu-00@starship>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@arcor.de (Daniel Phillips)  wrote on 09.09.02 in <E17oUzP-0006tu-00@starship>:

> On Monday 09 September 2002 21:48, Jamie Lokier wrote:
> > The expected behaviour is as it has always been: rmmod fails if anyone
> > is using the module, and succeeds if nobody is using the module.  The
> > garbage collection of modules is done using "rmmod -a" periodically, as
> > it always has been.
>
> Actually, it would be more useful if I stated the following simple fact:
> Returning a flag from __exit definitively gets rid of one race, that is
> the race where a module's memory can be freed while __exit is active.
>
> To get rid of this race by other means you have to put in place some
> fancy mechanism.  This alone should be enough reason to do it the way
> I suggest, besides the fact that it is a simpler, more obvious and more
> robust interface.

I just love the way you propose insanely hard-to-get-right, hard-to- 
understand, and complicated interfaces with known broken cases you admit  
to, to replace simple, obviously correct and race-free mechanisms, all  
with a supposed goal to make things simpler and safer.

Is there some fancy word to describe something that looks like irony,  
sarcasm, or satire, except for the fact it's actually meant entirely  
seriously?

MfG Kai
