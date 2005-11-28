Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVK1PvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVK1PvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 10:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbVK1PvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 10:51:04 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33481 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750907AbVK1PvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 10:51:01 -0500
Date: Mon, 28 Nov 2005 16:50:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Martin Drab <drab@kepler.fjfi.cvut.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PC speaker beeping on high CPU loads on an nForce2
In-Reply-To: <43892897.9020900@vc.cvut.cz>
Message-ID: <Pine.LNX.4.61.0511270927130.14029@yvahk01.tjqt.qr>
References: <Pine.LNX.4.60.0511270409430.30055@kepler.fjfi.cvut.cz>
 <43892897.9020900@vc.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> on an nForce2 system (GigaByte 7NNXP) when the CPU is under heavy load
>> (like during kernel compilation for instance, or any compilation of any
>> bigger project, for that matter), I hear some beeps comming out of the PC
>> speaker. It's like few short beeps per second for a while, then silence
>> for few seconds, then a beep here and there, and again, and so on. It is
>> quite strange. (I have the board for about 1.5 years).
>
> Nope.  Your system is overheating, and on-board temperature sensors are
> complaining.  Probably you should find whether lm-sensors have drivers for
> chips your motherboard has, and look at sensors output in that case...

Quite interesting, as I occassionally have short "drumbeat" on the PC 
speaker. It is like \e[10;x]\e[11;15], but seems irreproducible to me with 
any particular x. I do not suspect overheating, as the BIOS hardware 
monitor has shown 51 deg Celsius after some hours running for over two 
years now.

> Maybe ACPI could report thermal zone as well, try looking at
> /proc/acpi/thermal_zone/* tree.

MB is EliteGroup L7S7A2, CPU is AMD Athlon XP 2000+, and 
/proc/acpi/thermal_zone/ is empty. LM chip is a LM78, but lmsensors outputs 
only rubbish data.


Jan Engelhardt
-- 
