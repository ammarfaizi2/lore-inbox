Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286911AbRL1OL3>; Fri, 28 Dec 2001 09:11:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286912AbRL1OLT>; Fri, 28 Dec 2001 09:11:19 -0500
Received: from [217.7.64.198] ([217.7.64.198]:32164 "EHLO mx1.net4u.de")
	by vger.kernel.org with ESMTP id <S286911AbRL1OLF>;
	Fri, 28 Dec 2001 09:11:05 -0500
Message-Id: <200112281411.fBSEB3419310@mx1.net4u.de>
Content-Type: text/plain; charset=US-ASCII
From: Ernst Herzberg <earny@net4u.de>
Reply-To: earny@net4u.de
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 with acpi on a Laptop
Date: Fri, 28 Dec 2001 15:11:02 +0100
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200112272151.fBRLpe415377@mx1.net4u.de>
In-Reply-To: <200112272151.fBRLpe415377@mx1.net4u.de>
Cc: Juergen Sauer <jojo@automatix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 27. December 2001 22:51, Ernst Herzberg wrote:
> Hi,
>
>> i've got a Gericom m6-t Laptop, and i try to install Linux on it
>> (suse-7.3). With kernel 2.4.16 every works fine, but the internal
>> tulip-adaper and sound. Analyses shows, that there are something going
>> wrong with the irq-routing tables. I tried to install the acpi.sf.net on
>> this kernel, but that does'n work. With 2.4.17 i can see the first time
>> /proc/acpi, but the laptop will overheat after about 10 minutes. PCMCIA is
>> also not working, if there is a card sticking in a slot, the PC will die
>> without any errormessage (Starting kernel PCMCIA (using scheme: SuSE)). Any
>> idea? The Laptop has in the moment a direct internet-connecton with a fixed
>> ip-address (with 2.4.16 and 2.4.10 over a PCMCIA-Card).


> What about claiming your customer rights waranties and let the gericom 
> service fix their stuff or return the junk ?

> mfG
>         Jojo
> -- 

Yes, i've called gericom, and there are willing to do that. But i am not 
shure, that the problem is only on gericom site. With kernel 2.4.16 and all 
acpi patches applied the kernel doesn't create the /proc/acpi directory, but 
the cpu-fan keeps running when the kernel is booted. PCMCIA ist working 
without problems. With kernel 2.4.17 /proc/acpi is created, but the fan stops 
during kernel boot and will never be powered on again. That can damage the 
hardware. 

So why does the kernel power off the fan? If there is a userspace deamon 
needed to power on the fan, it is not possible to run the machine in level 1, 
or a longer installation like suse will never be possible;-) 

Even to track the problems is hard to do: You have only about 5 minutes time 
after boot....

<Earny>
