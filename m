Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267245AbTBDPY0>; Tue, 4 Feb 2003 10:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267275AbTBDPY0>; Tue, 4 Feb 2003 10:24:26 -0500
Received: from [205.205.44.10] ([205.205.44.10]:8206 "EHLO sembo111.teknor.com")
	by vger.kernel.org with ESMTP id <S267245AbTBDPYZ> convert rfc822-to-8bit;
	Tue, 4 Feb 2003 10:24:25 -0500
Message-ID: <5009AD9521A8D41198EE00805F85F18F219C29@sembo111.teknor.com>
From: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>
To: "Isabelle, Francois" <Francois.Isabelle@ca.kontron.com>,
       high-res-timers-discourse@lists.sourceforge.net,
       "'george@mvista.com'" <george@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: High-Res-Timers: Unexpected "lock" during "Calibrating delay 
	loop "
Date: Tue, 4 Feb 2003 10:33:58 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to add this: this seems to be reproducable on all 486 

> -----Original Message-----
> From: Isabelle, Francois [mailto:Francois.Isabelle@ca.kontron.com]
> Sent: 4 février, 2003 09:04
> To: high-res-timers-discourse@lists.sourceforge.net; 
> 'george@mvista.com'
> Cc: linux-kernel@vger.kernel.org
> Subject: High-Res-Timers: Unexpected "lock" during "Calibrating delay
> loop "
> 
> 
> Hi,
> 	we are having an unexpected problem with the HR patch( 
> regardless of
> the patch you sent which compiled just fine ). The board uses 
> a 486DX cpu,
> so there is no support for TSC nor ACPI, the only thing we 
> have is the PIT. 
> 
> Without highres, the kernel boots properly, with highres 
> enabled, the kernel
> passes "time_init()" put it hangs in "calibrate_loop() , ( I 
> though it hung
> for real, but it get passed the loop after a while) " 
> 
> Seems like the tick is VERY SLOW..
> 
> The PIT has been tested on this board, and without HR, the 
> kernel boots fine
> ... if you have any hints, they would be welcome.
> 
> The keyboard detection routine timeouts so the system is 
> quiet unuseable and
> I can't get the calibration results yet.
> 
> 
> Frank
> 
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.NET email is sponsored by:
> SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
> http://www.vasoftware.com
> to unsubscribe: 
> http://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
> High-res-timers-discourse mailing list
> High-res-timers-discourse@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/high-res-timers-discourse
> 
