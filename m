Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWBYOuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWBYOuv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWBYOuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:50:51 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:15110 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030257AbWBYOuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:50:50 -0500
Date: Sat, 25 Feb 2006 15:50:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] make INPUT a bool
Message-ID: <20060225145049.GQ3674@stusta.de>
References: <20060214182238.GB3513@stusta.de> <Pine.LNX.4.61.0602171655530.27452@yvahk01.tjqt.qr> <20060217163802.GI4422@stusta.de> <93564eb70602191933x2a20ce0m@mail.gmail.com> <20060220132832.GF4971@stusta.de> <20060222013410.GH20204@MAIL.13thfloor.at> <20060222023121.GB4661@stusta.de> <Pine.LNX.4.62.0602251255110.18095@pademelon.sonytel.be> <20060225124606.GI3674@stusta.de> <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602251521300.31692@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 03:22:04PM +0100, Jan Engelhardt wrote:
> >
> >My 50 MB number was much too high (I didn't want to think where exactly 
> >to set the borderline).
> >
> >My point is that if you are in an environment that is that space limited 
> >that you want to see options that allow e.g. not building futexes, 
> >module support with an impact of approx. 10% on code size would be one 
> >of the first things you should disable.
> >
> 
> You said that INPUT was not a driver, right. But without it, a keyboard 
> won't work, will it?

Yes, you do need INPUT for a keyboard.

No, INPUT alone does not support any hardware - that's the job of the 
drivers depending on INPUT.

No, I don't understand what your question wants to achieve.

> Jan Engelhardt

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

