Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWBYPaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWBYPaU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 10:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161009AbWBYPaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 10:30:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:37345 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1161008AbWBYPaT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 10:30:19 -0500
Date: Sat, 25 Feb 2006 16:29:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Adrian Bunk <bunk@stusta.de>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
In-Reply-To: <20060225145049.GQ3674@stusta.de>
Message-ID: <Pine.LNX.4.61.0602251628050.13355@yvahk01.tjqt.qr>
References: <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr>
 <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com>
 <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at>
 <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be>
 <20060225124606.GI3674@stusta.de> <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
 <20060225145049.GQ3674@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 
>> You said that INPUT was not a driver, right. But without it, a keyboard 
>> won't work, will it?
>
>Yes, you do need INPUT for a keyboard.
>
>No, INPUT alone does not support any hardware - that's the job of the 
>drivers depending on INPUT.
>
>No, I don't understand what your question wants to achieve.
>

Let's look at another subsystem:

"Yes, you do need SND for a soundcard."

"No, SND alone does not support any hardware - that's the job of the drivers
depending on SND."

Should SND also be made a bool like INPUT?


Jan Engelhardt
-- 
