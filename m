Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbRGMIxF>; Fri, 13 Jul 2001 04:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbRGMIwz>; Fri, 13 Jul 2001 04:52:55 -0400
Received: from sunu450.rz.ruhr-uni-bochum.de ([134.147.32.69]:59641 "HELO
	sunu450.rz.ruhr-uni-bochum.de") by vger.kernel.org with SMTP
	id <S266971AbRGMIwn>; Fri, 13 Jul 2001 04:52:43 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Joerg Schmitz-Linneweber <jsl@sth.ruhr-uni-bochum.de>
Organization: Ruhr-Universitaet Bochum, Lehrstuhl fuer Signaltheorie
To: Thomas Foerster <puckwork@madz.net>, linux-kernel@vger.kernel.org
Subject: Re: Again: Linux 2.4.x and AMD Athlon
Date: Fri, 13 Jul 2001 10:52:41 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010712071955Z267448-720+1447@vger.kernel.org>
In-Reply-To: <20010712071955Z267448-720+1447@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01071310524101.25182@p14>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am Donnerstag, 12. Juli 2001 09:15 schrieb Thomas Foerster:
> AMD Athlon 1,3 GHz, 266 FSB
> 2*128 MB Kingston SDRAM PC133
> Epox 8KTA3+ (VIA KT133A, via686b Southbridge)
> Linux 2.4.5-ac27
> (Powersupply is 400 Watt, Video is handled by GeForce2 GTS 32 MB)
> ...
> I've monitored my system using lm_sensors and didn't get any unusual high
> or low values (cpu is about 42°)
You mentioned, you've got a 400W power supply. But this does not mean you 
have enough (available) current on the 3.3V and 5V lines. Or perhaps your 
Core voltage is dropping very hard every time your "monster" graphics card 
draws a lot of current. Perhaps you should check that (partly possible via 
lm_sensors).

I also use a 400W supply with a TB1.4 GHz and I can see a drop on the 3.3V 
lines every time I start X on a GeForce 2MX...

Salut, Jörg
