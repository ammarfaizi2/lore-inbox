Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBHSnK>; Thu, 8 Feb 2001 13:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129098AbRBHSnB>; Thu, 8 Feb 2001 13:43:01 -0500
Received: from snowbird.megapath.net ([216.200.176.7]:45832 "EHLO
	megapathdsl.net") by vger.kernel.org with ESMTP id <S129031AbRBHSmz>;
	Thu, 8 Feb 2001 13:42:55 -0500
Message-ID: <3A82E8AC.9080900@megapathdsl.net>
Date: Thu, 08 Feb 2001 10:42:52 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-ac5 i686; en-US; m18) Gecko/20010207
X-Accept-Language: en
MIME-Version: 1.0
To: christophe barbe <christophe.barbe@inup.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Animated framebuffer logo for 2.4.1
In-Reply-To: <20010208004021.D189@bug.ucw.cz> <Pine.LNX.4.33.0102080736190.5431-100000@asdf.capslock.lan> <20010208150859.A19950@pc8.inup.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

christophe barbe wrote:

> Ok it seems not important to have a nice boot process but each time you show a linux machine to a M$ normal user (normal = not a programmer) his first reaction is something like ""what are all these strange output lines?". And it's the first thing that keep Windows user in the dark side. 
> Windows hides (or try to do) all messages by a blue screen (light blue, when you are lucky). 
> 
> For these reason, I use LPP (linux patch progress). It's a little patch. The main idea is : redirect all boot messages on the second console, display on the first one a bigger framebuffer logo (screen size) and draw on it the progress bar, progress text and warning messages. A proc interface is provided for the second part of the boot process (echo "starting X Font Server" > /proc/progress).
> 
> The boot is not significantly longer (and with a well fitted kernel, is really faster than M$ Wx) and suddendly the first linux impression is really good.
> 
> I hope this kind of patch can be integrated in the kernel.

Hi Christophe,

I agree that non-technical folks will be put off by
being shown the guts of the system.  But, I think the
kind of patch you are talking about belongs as either
an optional patch set aside for distribution developers
to apply to their retail kernels or as a configuration
option in the kernel tree.  The default should probably
be that anyone who builds their own kernel gets exposed
to the system internals.  

I do agree that there is a great need for the kind 
of functionality you describe.  With LPP, all the 
technical stuff is still accessible and user manuals
for retail distributions could easily guide the naive
user to that information in case of system problems.

	Miles

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
