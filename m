Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310892AbSCHOso>; Fri, 8 Mar 2002 09:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310890AbSCHOsg>; Fri, 8 Mar 2002 09:48:36 -0500
Received: from [195.63.194.11] ([195.63.194.11]:11270 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310884AbSCHOsZ>; Fri, 8 Mar 2002 09:48:25 -0500
Message-ID: <3C88CEF6.8010603@evision-ventures.com>
Date: Fri, 08 Mar 2002 15:47:18 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.6 IDE oops with i810 chipset
In-Reply-To: <Pine.LNX.4.44.0203081514430.28035-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> HI,
> 
> It is almost impossible to boot 2.5.6 with IDE disk with
> chipset :
> 
> 00:1f.1 IDE interface: Intel Corporation 82801AA IDE (rev 02) (prog-if 80
> [Master])
>         Subsystem: Intel Corporation 82801AA IDE
>         Flags: bus master, medium devsel, latency 0
>         I/O ports at 2460 [size=16]
> 
> 
> I get an oops with every configuration I tried.
> Of course I have no way to save log this oops,
> and I had no time to write it down. Anyway it is the usual
> "attemped to kill init" message.
> 
> Apart of this there is the old OSS driver with still
> a virt_to_bus() in dma.c file,
> and drm/i810.c has the same problem too, also if a trivial
> (and of course wrong, also if it works temporally) fix
> is quite fast.

Could you please tell me which was the last version (possible up to
pre status) which worked? And could you possible tell where the
system actually hangs during the boot process (what is the
last init message which appears on the screen?).

During IDE setup? During mounting? During fsck or whatever.
I'm asking this becouse I couldn't get patch-2.5.6-pre3 working
on my athlon system and there are as well apparent instabilities
on my i440MX based notebook, which are not related to the IDE changes.
(pre2 with patch number 16 and 17 applied works for me of course on
both of them quite well...)

Thank you in advance.

