Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282685AbRK0Ap0>; Mon, 26 Nov 2001 19:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282686AbRK0ApP>; Mon, 26 Nov 2001 19:45:15 -0500
Received: from host113.south.iit.edu ([216.47.130.113]:48257 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S282685AbRK0ApH>;
	Mon, 26 Nov 2001 19:45:07 -0500
Message-ID: <3C02E1F8.8090407@lostlogicx.com>
Date: Mon, 26 Nov 2001 18:44:40 -0600
From: Lost Logic <lostlogic@lostlogicx.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Nathan G. Grennan" <ngrennan@okcforum.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <1006812135.1420.0.camel@cygnusx-1.okcforum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running 2.4.16 with 2 IDE UDMA mode 4 drives, and I have experienced 
no such pausing no matter what I do.  (which usually includes patching, 
extracting, and generally messing with kernels from Eterm with XMMS 
playing, and a couple mozillas open)

Nathan G. Grennan wrote:

>2.4.16 becomes very unresponsive for 30 seconds or so at a time during
>large unarchiving of tarballs, like tar -zxf mozilla-src.tar.gz. The
>file is about 36mb. I run top in one window, run free repeatedly in
>another window and run the tar -zxf in a third window. I had many
>suspects, but still not sure what it is. I have tried
>
>ext2 vs ext3
>preemptive vs non-preemptive
>tainted vs non-tainted
>
>Nothing seems to help 2.4.16.
>
>I tried switching to Redhat's 2.4.9-13 kernel and it acts Alot better.
>Not only does 2.4.9-13 not get the 30 second delay, but it also seems to
>take advantage of caching. 2.4.16 takes the same moment of time each
>time, even tho it should have cached it all into memory the first time.
>2.4.9-13 takes a while the first time(without the 30 second new process
>freezing), but then takes almost no time the times after that. One
>interesting thing I noticed is that with and without preemptive a
>already started mp3 playing had no disruption even during the 30 second
>windows where any new commands would get stuck with 2.4.16. I am not
>using custom
>
>I plan to do more testing to see how say 2.4.9, 2.4.13ac7, etc. 
>
>Any ideas of how to fix this for 2.4.16?
>
>I have attached my .config.
>
>My system:
>
>Redhat 7.2 with all updates
>
>Athlon Thunderbird 1.33ghz
>768mb(512mb, 256mb) PC133 SDRAM
>Abit KT7A-RAID v1.0(KT133A chipset)
> Bios 64
> HPT370(bios v1.2.0604)
>   Primary Master   Quantum Fireball AS40.0
>   Secondary Master IBM-DTLA-307045
> VIA686B 
>   Primary Master   CREATIVE DVD-ROM DVD6240E
>   Secondary Master CR-2801TE
>


