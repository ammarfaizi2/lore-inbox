Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267448AbRGLHUM>; Thu, 12 Jul 2001 03:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267449AbRGLHUC>; Thu, 12 Jul 2001 03:20:02 -0400
Received: from mohawk.n-online.net ([195.30.220.100]:19213 "HELO
	mohawk.n-online.net") by vger.kernel.org with SMTP
	id <S267448AbRGLHTv> convert rfc822-to-8bit; Thu, 12 Jul 2001 03:19:51 -0400
Date: Thu, 12 Jul 2001 09:15:51 +0200
From: Thomas Foerster <puckwork@madz.net>
To: linux-kernel@vger.kernel.org
Subject: Again: Linux 2.4.x and AMD Athlon
X-Mailer: Thomas Foerster's registered AK-Mail 3.11 [ger]
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <20010712071955Z267448-720+1447@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

i've upgraded from an AMD Athlon 650 to this system :

AMD Athlon 1,3 GHz, 266 FSB
2*128 MB Kingston SDRAM PC133
Epox 8KTA3+ (VIA KT133A, via686b Southbridge)
Linux 2.4.5-ac27

(Powersupply is 400 Watt, Video is handled by GeForce2 GTS 32 MB)

Compiling the kernel works great, fast and stable. Whenever there is high load
on the systembus (e.g. compiling some source) the noise of my powersupply fans increase.
(Not under Windows, so i think linux makes much more use of the power of AMD's CPUs)

I ran memtest86 for hours without any problems, i couldn't crash the system or any process..
until i start X 4.0.3.

I've tested it with KDE2 and Gnome 1.2. After a (mostly) successful start of one of the 
windowmanagers, most applications crush whenever i open them.
Running console-applications in xterm or compiling the kernel in xterm works still stable, but
working with X11 apps is no more fun ... crashes all over ... (segfaults, sig 11)

This message is meant to be a better approach in solving the problem(s) with AMD Athlons/Durons.

I didn't overclock anything. Compiling the kernel with K6-2 Support or PIII fixes the problems
(and the noise of the power-fan stays constant, so i think the cpu-power isn't used to the max :) )

I've monitored my system using lm_sensors and didn't get any unusual high or low values
(cpu is about 42°)

Seems to be the problem with the AMD optimazion in the kernel.

Thomas

