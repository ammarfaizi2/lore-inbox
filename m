Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264885AbSLaWfh>; Tue, 31 Dec 2002 17:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264886AbSLaWfh>; Tue, 31 Dec 2002 17:35:37 -0500
Received: from ext-ch1gw-3.online-age.net ([216.34.191.37]:24315 "EHLO
	ext-ch1gw-3.online-age.net") by vger.kernel.org with ESMTP
	id <S264885AbSLaWfg>; Tue, 31 Dec 2002 17:35:36 -0500
Message-ID: <A9713061F01AD411B0F700D0B746CA680489562D@vacho6misge.cho.ge.com>
From: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
To: "'Anthony J. Breeds-Taurima'" <tony@cantech.net.au>,
       Herman Oosthuysen <Herman@WirelessNetworksInc.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Indention - why spaces?
Date: Tue, 31 Dec 2002 17:43:40 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> indent itself dosen't have a 'Linux standard' BUT 
> .../linux/scripts/Lindent
> is there to get things right (in terms of CodingStyle)

Thanks, I wasn't aware of that one, but had created my own version.

A couple more gallons of fuel to the flame :)

>From .../linux/scripts/Lindent:
 indent -kr -i8 -ts8 -sob -l80 -ss -bs -psl "$@"

-psl: seams to be inconsistent with much of the kernel code.
6 == half dozen IMHO.

-sob: Ackkk! I prefer to have two blank lines between functions. I think it
just
makes things easier for the eyes to parse. But in general, I'd say respect
the
authors judgement in use of blank lines.
