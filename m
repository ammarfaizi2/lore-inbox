Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262194AbTCHUm6>; Sat, 8 Mar 2003 15:42:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262197AbTCHUm6>; Sat, 8 Mar 2003 15:42:58 -0500
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:10880 "EHLO
	ds666.starfleet") by vger.kernel.org with ESMTP id <S262194AbTCHUm4>;
	Sat, 8 Mar 2003 15:42:56 -0500
Message-ID: <3E6A5861.7070507@portrix.net>
Date: Sat, 08 Mar 2003 21:53:53 +0100
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030305
X-Accept-Language: en
MIME-Version: 1.0
To: jsimmons@infradead.org
CC: linux-kernel@vger.kernel.org, siim@pld.ttu.ee
Subject: Re: Console weirdness
References: <3E6A1A7F.8090409@portrix.net>
In-Reply-To: <3E6A1A7F.8090409@portrix.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using patches from 
"http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz" as suggested by 
Siim Vahtre, oops goes away, but the other problems persist. The console 
is even worse. Seeing a cursor blinking to the lower left, but the rest 
of the screen is pretty colorful ;-).
Any specific kernel version I can try out? But I think rivafb was broken 
until recently...

jan


Jan Dittmer wrote:
> I'm not seeing any boot messages during boot up. The fb-penguin  gets 
> drawn though. X is starting fine and is usable and I even see the login 
> prompt - but nothing in between. This also happens with fb disabled.
> Additionally I have the following warning in dmesg output after bootup.
> Another thing I noticed is, that the last line of the screen doesn't 
> seem to get cleared in fb mode. So pressing 'Enter' will move the screen 
> contents up one line but the last line isn't cleared.
> Otherwise this kernel is really working find.
> .config is attached (latest bk). Let me know if I can provide any more 
> data.
> 
> Greets, jan
> 
> 
> rivafb: nVidia device/chipset 10DE0253
> rivafb: Detected CRTC controller 0 being used
> rivafb: RIVA MTRR set to ON
> rivafb: PCI nVidia NV20 framebuffer ver 0.9.5b (nVidiaGeForce4 T, 64MB @ 
> 0xD8000000)
> Badness in kobject_register at lib/kobject.c:152
> Call Trace:
>  [<c026d598>] kobject_register+0x58/0x70
>  [<c02a6d2f>] bus_add_driver+0x5f/0xf0
>  [<c02a71df>] driver_register+0x2f/0x40
>  [<c02757f7>] pci_register_driver+0x47/0x60
>  [<c010507a>] init+0x3a/0x160
>  [<c0105040>] init+0x0/0x160
>  [<c010923d>] kernel_thread_helper+0x5/0x18
> 
> Console: switching to colour frame buffer device 80x30
> 


