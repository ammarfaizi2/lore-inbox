Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267011AbTBHPB4>; Sat, 8 Feb 2003 10:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267005AbTBHPB4>; Sat, 8 Feb 2003 10:01:56 -0500
Received: from mail.epost.de ([193.28.100.167]:21144 "EHLO mail.epost.de")
	by vger.kernel.org with ESMTP id <S267003AbTBHPBz>;
	Sat, 8 Feb 2003 10:01:55 -0500
Message-ID: <3E451E2B.3000901@epost.de>
Date: Sat, 08 Feb 2003 16:11:39 +0100
From: Oliver Sniehotta <oliver.sniehotta@epost.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020903
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: agpgart fails with Via KT400 and GeForce 4200-8x
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a system with Via KT400 Mobo and a GeForce 4200-8x
graphics card.
When I try to load the agpgart module, I get the following
message, that agpgart is unable to determine aperture size:


---- output of dmesg -----------------------------------------

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Detected Via Apollo Pro KT400 chipset
agpgart: unable to determine aperture size.

--------------------------------------------------------------

This happens with 2.4.19 , 2.4.20, 2.4.21-pre2 and -pre4.
I think this a problem with AGP-8x.
Is there any chance to force AGP-4x or to tell the module
about the aperture size ?



Regards
  Oliver




     _/_/_/_/   _/      _/_/_/  Oliver Sniehotta
    _/    _/   _/      _/
   _/    _/   _/      _/_/_/    email: oliver.sniehotta@epost.de
  _/    _/   _/          _/
_/_/_/_/   _/_/_/  _/_/_/

