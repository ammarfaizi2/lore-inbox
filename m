Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265863AbSLXVNb>; Tue, 24 Dec 2002 16:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265865AbSLXVNb>; Tue, 24 Dec 2002 16:13:31 -0500
Received: from f178.law7.hotmail.com ([216.33.237.178]:37893 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S265863AbSLXVNa>;
	Tue, 24 Dec 2002 16:13:30 -0500
X-Originating-IP: [198.70.229.121]
From: "Randy S." <hey_randy@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: nForce2 chipset and agpgart: unsupported bridge?
Date: Tue, 24 Dec 2002 16:21:37 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F178vHerWJncooYw6zX00012563@hotmail.com>
X-OriginalArrivalTime: 24 Dec 2002 21:21:38.0157 (UTC) FILETIME=[71BCD1D0:01C2AB92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

  I recently acquired a motherboard with an NVidia nForce 2 chipset (more 
specifically, its a Chaintech CT-7NJS). I have a Radeon 9700PRO video card 
that I'm running in this machine.  I've got integrated networking, sound, 
XFree86, etc. working, but am having trouble getting 3D acceleration to 
work.

   My kernel is 2.4.19.  Agpgart does not appear to be able to detect the 
nForce 2 chipset's bridge. There is no vendor entry for nvidia at all, 
actually -- otherwise I might have gotten by with agp_try_unsupported=1.

   Has anyone written nForce2 support for agp? Is so, where can I find the 
source?   I found drivers for the nvidia IGP (which I don't have), but not 
for agpgart itself at the nvidia site.  If I find the source, I believe I'll 
have to merge it manually since the 3D driver for Radeon 9700 (fglrx) 
includes a modified agpgart_be.c.

    If this is not a new question, my apologies -- I couldn't find an answer 
anywhere in the archives.

   Please CC me directly on any reply, as I'm not currently subscribed.

Thanks!
   Randy Sharo
   hey_randy@hotmail.com


_________________________________________________________________
MSN 8: advanced junk mail protection and 3 months FREE*. 
http://join.msn.com/?page=features/junkmail&xAPID=42&PS=47575&PI=7324&DI=7474&SU= 
http://www.hotmail.msn.com/cgi-bin/getmsg&HL=1216hotmailtaglines_advancedjmf_3mf

