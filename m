Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291885AbSBNUun>; Thu, 14 Feb 2002 15:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291882AbSBNUue>; Thu, 14 Feb 2002 15:50:34 -0500
Received: from smtp3.vol.cz ([195.250.128.83]:47120 "EHLO smtp3.vol.cz")
	by vger.kernel.org with ESMTP id <S291885AbSBNUu1>;
	Thu, 14 Feb 2002 15:50:27 -0500
Date: Thu, 14 Feb 2002 20:05:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marco Colombo <marco@esi.it>, linux-kernel@vger.kernel.org
Subject: Re: Quick question on Software RAID support.
Message-ID: <20020214190536.GA160@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.44.0202131109270.21300-100000@Megathlon.ESI> <E16axOE-0004zX-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16axOE-0004zX-00@the-village.bc.nu>
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I had a raid1 IDE system, and it was continuosly raising hard errors on
> > hdc (the disk was dead, non just some bad blocks): the net result was that
> > it was unusable - too slow, too busy on IDE errors (a lot of them - even
> > syslog wasn't happy).
> 
> Don't try and do "hot pluggable" IDE raid it really doesn't work out. With
> scsi the impact of a sulking drive is minimal unless you get unlucky
> (I have here a failed SCSI SCA drive that hangs the entire bus merely by
> being present - I use it to terrify HA people 8))

I could imagine scenario when disk would set itself on fire...

...which was reason why disks in sun4/330 were separate by steel so
fire in disks would not damage mainboard ;-).
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
