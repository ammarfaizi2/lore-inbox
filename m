Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271003AbUJUWWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271003AbUJUWWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270990AbUJUWTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:19:48 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:18842 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S271027AbUJUWDy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:03:54 -0400
Message-ID: <41783245.2030905@verizon.net>
Date: Thu, 21 Oct 2004 18:03:49 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
References: <4176E08B.2050706@techsource.com> <4176E671.4090104@verizon.net> <4177CCE5.60904@techsource.com>
In-Reply-To: <4177CCE5.60904@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.211.53] at Thu, 21 Oct 2004 17:03:49 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> 
> 
> Jim Nelson wrote:
> 
>> Timothy Miller wrote:
>>
>>> I can produce more detail later, but first, some characteristics and 
>>> advantages of what I'm proposing:
>>>
>>> - x86 BIOS/OpenBoot/OpenFirmware code under BSD and GPL license
>>> - kernel drivers under BSD and GPL license
>>> - X11 module under MIT license
>>> - flashable PROM so that boot code can be added for more platforms
>>> - usable as the console on any platform that can take a PCI, AGP, or 
>>> PCI-Express card
>>> - downloadable schematic for the circuit board
>>> - FPGA-based graphics engine so it's reprogrammable
>>> - instructions on how to reprogram the FPGA, so it's hackable
>>> - if we discontinue a product, we may release the Verilog code for 
>>> the FPGA
>>> - Since this is designed to be open-source-friendly, we want to play 
>>> by the rules of the open-source community.
>>> - Tech Source would actively participate in the development and 
>>> maintenance of our own drivers.
>>> - We will actually pay attention to problems and concerns raised by 
>>> users and developers.
>>> - We won't be control-freaks.
>>
>>
>>
>>> I haven't worked out a complete design spec for this product.  The 
>>> reason is that what we think people want and what people REALLY want 
>>> may not be congruent.  If you have a good idea for a piece of 
>>> graphics hardware which you think would be beneficial to the free 
>>> software community (and worth it for a company to produce), then Tech 
>>> Source, as a graphics company, might be willing to sell it.
>>>
>>>
>>
>> You might want to take a look at the onboard video market.  Providing 
>> an open-source 2D rendering engine and the PCI glue logic that work on 
>> an FPGA would probably revolutionize embedded PC applicatiuons that 
>> rely on a graphical interface.  Providing support to motherboard 
>> manufaturers who might want a low-cost onboard video solution 
>> (micro-ITX, etc) is another possibility.
> 
> 
> Now, THIS is an excellent idea.  If the volumes there would be high 
> enough, it could be what justifies the project.  We have had customers 
> wanting embedded solutions, and through this project, we could provide 
> them something even better in the future.
> 

That would be your value-add there - provide the experience in video 
system design to the low-volume (<5000 unit) custom controller market. 
Smaller companies will not have the video experience to implement 
something like this.  You could even bill the PCI cards as "developer 
tools".  You'd just sell a lot of developer cards to *nix people...

>> You also might want to look at PC/104 and CompactPCI form factors - I 
>> think the industrial market will be a great target, and, after all, if 
>> you have to move 80% industrial equipment to justify the 20% AGP 
>> sales, it makes good sense.  There might even be a market for ISA, 
>> SBus, and MCA cards, for people stuck supporting seriously old 
>> machines (386, 486, SPARC) where it's almost impossible to find 
>> working graphics cards. Even if it's a DOS machine, hardware is 
>> hardware, and a brand-new VL-bus card for someone's 486 would be 
>> pretty cool :)
> 
> 
> This is a good idea too.  I've already decided to try to fit it onto a 
> 1/2 height, short PCI card (like the low-end 3ware cards) so that you 
> can put the card into one of these compact cases.
> 
> At this time, I'm not sure it's worth it to do anything other than PCI, 
> AGP, and PCIE, however.  Of course, if someone comes along with a large 
> enough order, we'd be plenty willing to do whatever customization they 
> want.
> 

I dunno.  That's what market research weenies are paid to do - figure 
out if the market for a product is good enough to justify developement.

If this does work, though, moving the core graphics rendering engine to 
an ASIC would mean that a very small amount of work would be necessary 
to move the core to various bus architectures - even high-end PDA's and 
cell phones are going to need some serious graphics horespower soon, if 
the screens on them keep going like they are.

You also might want to consider marketing "developer kits" that include 
dead-tree documentation, boards, re-branded FPGA tools, and raw chips 
for those looking to do custom work on their own.  I think it'd be fun 
to hack up an ISA graphics card on my own, even if mass production isn't 
feasible :)

It could be marketed to universities needing an undergraduate project in 
hardware design, too - for everything from video BIOS development to PCI 
interfacing to DAC implementation and physical board design.  And the 
students wouldn't need to sign an NDA to get access to the cool new 
hardware...
