Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129445AbRAXV6q>; Wed, 24 Jan 2001 16:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRAXV6g>; Wed, 24 Jan 2001 16:58:36 -0500
Received: from isis.telemach.net ([213.143.65.10]:12042 "HELO
	isis.telemach.net") by vger.kernel.org with SMTP id <S129445AbRAXV6Y>;
	Wed, 24 Jan 2001 16:58:24 -0500
Message-ID: <3A6F5004.D8954FA4@telemach.net>
Date: Wed, 24 Jan 2001 22:58:28 +0100
From: Jure Pecar <pegasus@telemach.net>
Organization: Select Technology
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 hangs with PIII i815e system
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> Recently, i got a new and shiny PIII 700Mhz, 64MB box, with Intel 
> motherboard based on the i815e chipset, with intergrated 
> NIC/Audio/Graphic. 

> The machine ran smoothly with the supplied 2.2.16 kernel, yet i decided 
> to upgrade to 2.4.0. 

> But since upgrading to 2.4.0, i have random, unexpected lock-ups, and that 
> means TOTAL lock-up, no console switching, no SysRQ key, nothing responds. 

> I first tried removing all of the(probably troublemaking) i81x features, 
> ICH2 audio driver, DRI and AGP were all moved out of the kernel, yet 
> lockups still occour. 

> If i can point at a common cause, all these lock-ups except one occoured 
> while downloading something, and in all cases squid 2.2. was running. 

> I include the kernel config file, and kernel bootup messages,hopefully, it 
> will help debugging the problem 

I can only confirm that strange things are happening indeed with intel's
D815EEA board and 2.4.0 kernels. I have 15 such boxen (and lot more to
come next month), all with exact same configuration, yet 10 of these are
working ok, of other 5 one cant even reach a couple of hours of uptime,
other four managed 2 days uptime so far. They all have installed redhat7
with their rawhide 2.4.0-0.43 kernel rpm. So far all 15 boxen stand
idle, i just ping them from time to time to check if they're still up.
I really _really_ hope this is a hardware problem. One weird thing i
came up with is that all boxen that were crashing have noticeably warmer
cpu heatsinks that those which dont crash, yet all fans were spinning as
they should. So could this be something in the kernel? There are
absolutely no mesgs ni logs indicating that something is wrong... 

All suggestions welcome.

--

Jure Pecar
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
