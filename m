Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278742AbRKOAqX>; Wed, 14 Nov 2001 19:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKOAqN>; Wed, 14 Nov 2001 19:46:13 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:39428 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S278742AbRKOAqC>;
	Wed, 14 Nov 2001 19:46:02 -0500
Message-Id: <5.1.0.14.0.20011115111324.01f0c540@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 15 Nov 2001 11:45:53 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: What Athlon chipset is most stable in Linux?
Cc: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011113.191607.00304518.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.30.0111131910440.9658-100000@anime.net>
 <20011113.183256.15406047.davem@redhat.com>
 <Pine.LNX.4.30.0111131910440.9658-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 07:16 PM 13/11/01 -0800, David S. Miller wrote:
>What is your quake3 com_maxfps set to?  By default it is 85, and
>that can hide the bug.  Set it to 130 or something like that.
>
><snip!>
>
>I'm rather sure the AMD761 problems are motherboard vendor
>independant, because I have 2 systems so far, using totally different
>AMD761 based motherboards, which both hang pretty reliably with AGP.

Last night I decided to test this out on my Asus A7M (AMD761 and VIA 686b), 
which has a 1.4 Ghz Athlon, Creative SBLive!, 3Com 3c905B, and an Asus 
V8200 (GeForce3 64Mb DDR). The case has very good airflow, at about 120 
Cubic Feet per Minute, and most of this passes past the CPU. PSU is a 300W 
Enhance (brand name) power supply - use a lot of this brand, and they are 
good quality. Linux kernel is 2.4.14 vanilla, with the Nvidia 1.0-1541 
binary driver (using kernel AGPgart, and Nvidia module options for speed), 
XFree86 4.1.0 that is currently in Debian sid. Was running at 1024x768 at 
24 bit, defaults for Q3A texture settings, sound, etc, with /com_maxfps set 
to 255. I played the single player setup against the bots (in the medium 
hardness setting - I didn't lose a round, which kept the 3D going as 
continuous as possible) from the start to the finish (all 6 tiers and the 
final Z tier) without a lockup. Note: I do not run the Riva FrameBuffer 
module, nor do I enable ANY of the APM options (eg: Make CPU Idle calls, 
Enable console blanking, etc) in the kernel, just the generic APM support 
itself - mainly so the machine shuts off automatically after shutdown).

AGP and bad Power Supplies are always a problem, especially when you try 
and exploit anything greater than 1x AGP, and the power drain really rises. 
Heat is always an issue, but with good cooling, most problems vanish.

Sure that beanie of yours isn't cutting off the circulation, or that you've 
been drinking too much V again Dave? *joke*

BTW: As a member of a group called the LGL (or Linux Gamers League) here in 
Australia, I help out a lot of people who want to get their systems running 
games, particularly 3D stuff like Q3A, UT, and Tribes2. I've been able to 
track down most of the crash issues with AMD 76x chipsets to either 1) bad 
quality components, 2) heat or 3) power supplies. Admittedly AMD 760 
(vanilla, not sure about MP) chipsets don't like doing more than 1x AGP, 
but since they are a bit old in the tooth now, this isn't so much of a 
problem for us gamers. If there was a huge issue with this, I'm sure you'd 
hear a hell of a lot of the guys and girls (yes, girls play games under 
Linux too!) in the LGL complaining about it. *grin*

Take care.


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

