Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752142AbWIXTLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752142AbWIXTLg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbWIXTLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:11:36 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:51512 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1752142AbWIXTLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:11:35 -0400
Date: Sun, 24 Sep 2006 13:13:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Bug: Asus CUR-DLS and 2.6
In-reply-to: <fa.oxv6SpXdmGM3attVfc3DVbNIcEk@ifi.uio.no>
To: Mark Felder <felderado@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <4516D8DF.4060402@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.oxv6SpXdmGM3attVfc3DVbNIcEk@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Felder wrote:
> With a 2.6.15 and 2.6.16 kernel on Gentoo I would receive 3 beeps and it would 
> hardlock as I expained. The CPU fans shut off -- there's no hope of bringing 
> it out of this. Rarely it's happened at GRUB or before GRUB, but only when 
> I've been working on this for a long period of time. 

It seems really unlikely that the kernel is causing this. Especially if 
the CPU fans shut off, how would the kernel cause this to happen?

> 
> I've tried many live CDs -- most use recent 2.6 kernels, and I could repeat 
> nearly the same problem on them. It often occurs when starting networking. 
> I've tried onboard e100, tulip, and others that I have access to and I get 
> nearly the same results. Depending on the livecd I can either get a hardlock 
> + 3 beeps, or I can receive an address via DHCP, but I can't speak to the 
> network at all. The e100 reports "system timing errors" in this occasion. On 
> some setups I can reproduce it instantly by having the network cable 
> unplugged and plugging it in after it's brought up the e100 interface.

Might be unrelated, or caused by the same root cause.

> 
> Now I was under the inital impression that I had bad hardware. I've 
> thouroughly tested my RAM and even replaced the motherboard with an identical 
> ASUS CUR-DLS, so right now I have two of them on my hands, and the one I just 
> got has the most recent BIOS, the other did not. The only hardware bug that I 
> can see is that one processor incorrectly reports its temperature -- stays 
> around 50 celcius all the time, but I figure that's just a bad sensor.

Are you certain? Seems suspicious.

> 
> I came to the conclusion it must be a 2.6 bug when I dropped in a Slackware CD 
> I just picked up recently. It uses a 2.4 kernel. To my surprise it worked 
> fine -- no hardlocks, network works great on all adapters, including onboard. 
> Very strange stuff indeed.

It may some kind of hardware issue that 2.6 is triggering and 2.4 did not.

> 
> Things I've tried with the 2.6 include apic/noapic, nosmp and swapped 
> processors to each other's slots, nolapic (dont think it actually works for 
> SMP though, I'm not sure on that one), and nearly every combination of them. 
> The only other thing I've noticed is that some livecds report an apic but 
> when initializing the kernel -- right at the very beginning, and it says to 
> report them to the hardware manufacturer and it claims to work around it.

Can you post the full dmesg please?

> 
> This motherboard uses the Serverworks chipset. I'm not using SCSI.
> 
> I would really like to get this bug squashed -- I have a use for this system 
> and I'd really really prefer to use a 2.6 kernel. Now since I have an 
> identical motherboard on hand, if anyone is interested in figuring out what 
> is going on and would like hands on access to the hardware, I could get you 
> one of these motherboards. If you really don't have access to PIII's/RAM to 
> put in it, I could the whole setup off too, but I'd really like to get it 
> back if possible.
> 
> I'm open to any suggestions you might have. As of this moment, I'm not on the 
> kernel mailing list, but I will be looking to sign up after I send this off. 
> 
> Thank you for your time, and keep up the great work everyone :)
> 
> 
> Mark Felder
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

