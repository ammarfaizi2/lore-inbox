Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279874AbRKFSKQ>; Tue, 6 Nov 2001 13:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279884AbRKFSKH>; Tue, 6 Nov 2001 13:10:07 -0500
Received: from grex.cyberspace.org ([216.93.104.34]:54033 "HELO
	grex.cyberspace.org") by vger.kernel.org with SMTP
	id <S279874AbRKFSJv>; Tue, 6 Nov 2001 13:09:51 -0500
Message-ID: <20011106130955.A15828@grex.cyberspace.org>
Date: Tue, 6 Nov 2001 13:09:55 -0500
From: Step 1 B <step1b@cyberspace.org>
To: Tyler BIRD <BIRDTY@uvsc.edu>, step1b@cyberspace.org,
        linux-kernel@vger.kernel.org
Subject: Re: regd kernel compilation
In-Reply-To: <sbe7bac4.014@MAIL-SMTP.uvsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.1
In-Reply-To: <sbe7bac4.014@MAIL-SMTP.uvsc.edu>; from Tyler BIRD on Tue, Nov 06, 2001 at 10:25:43AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The number of hardware ettings is just too many,and so I  fear
I may go somewhere  wrong. so I want it the automatic way only.

1. Is this approach been discussed earlier too ? How easy/tough is it 
  to do it ? how good/bad is it ?

2. How is hardware detected ? Which part of the kernel source should
I look at ?

Again, please cc me the responses.



On Tue, Nov 06, 2001 at 10:25:43AM -0700, Tyler BIRD wrote:
> Do you mean hardware detection during kernel compilation?
> the /proc filesystem lists devices that are currently present on your system
> int /proc/devices I think.  But for the most part I just know what kind of hardware
> I have and configure the kernel appropriately.  In the config scripts you can leave
> off any modules that aren't needed.  Compile them as a module or compile them into the
> kernel image.
> 
> do a make menuconfig, or if you have X make xconfig
> and enable/disable all of your hardware.
> 
> Tyler
> 
> 
> >>> Step 1 B <step1b@cyberspace.org> 11/06/01 10:17AM >>>
> 
> Hi
> During the processing of compiling the kernel and getting it running, I
> observed that my kernel not only contains software for my current hardware
> configuration, but also for other hardware as well.(both in the kernel and
> as modules). and during bootup, the kernel identifies the hardware and
> either uses the concened part in the kernel, or loads the concerned
> module. Cant this be done during compilation(ie., kernel building) itself
> so that I get a smaller kernel and a smaller set of modules on my disk ? 
> Or is just that the current kernel compilation framework does not support
> this ? 
> 
> Note that I do not know what hardware I have, so I want the 
> compilation scripts to identify the hardware and make the correct and minimal config.
> 
> 
> 
> I am not on this mailing list, so please
> cc me any responses.
> 
> thanks
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
