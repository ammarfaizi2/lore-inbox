Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUADAwu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 19:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264405AbUADAwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 19:52:50 -0500
Received: from luli.rootdir.de ([213.133.108.222]:53401 "EHLO luli.rootdir.de")
	by vger.kernel.org with ESMTP id S264386AbUADAwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 19:52:49 -0500
X-Qmail-Scanner-Mail-From: claas@rootdir.de via luli
X-Qmail-Scanner: 1.20 (Clear:RC:1(217.186.136.236):SA:0(-4.4/5.0):. Processed in 0.211378 secs)
Date: Sun, 4 Jan 2004 01:52:46 +0100
From: Claas Langbehn <claas@rootdir.de>
To: =?iso-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0: atyfb broken
Message-ID: <20040104005246.GA2153@rootdir.de>
References: <20040103233728.GA22427@rootdir.de> <Pine.LNX.4.44.0401040041160.10711-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0401040041160.10711-100000@deadlock.et.tudelft.nl>
Reply-By: Wed Jan  7 01:36:48 CET 2004
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.1-rc1 i686
X-No-archive: yes
X-Uptime: 01:36:48 up 53 min,  7 users,  load average: 0.00, 0.09, 0.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniël!

> What to do?
> 
> The best thing you can try is to connect a CRT. Its a handy tool (it
> eats any video mode, including wrong ones) to check if the driver does
> something wrong. Use it to inspect geometry and the horizontal & vertical
> refresh rates. The CRT should dislay 1024x768 60 Hz in all resolutions
> (unless you switch off the LCD display).
> 
> Compile Atyfb as module. Use fbset to switch video modes blindly. Check
> the following modes: 640x400, 640x480, 1024x768.

Okay, the external monitor was a good idea.
I can boot with the external monitor and atyfb.

when I do fbset 1024x768-60, then the screen gets distorted, then I hit
Fn + F5 (Monitor selection) several times, and finally I get a working
picture.

So tell me how we can do register debuggig.


Regards, claas

