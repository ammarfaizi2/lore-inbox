Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130723AbRCEWT5>; Mon, 5 Mar 2001 17:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130724AbRCEWTr>; Mon, 5 Mar 2001 17:19:47 -0500
Received: from [213.97.199.90] ([213.97.199.90]:19716 "HELO roku.redroom.com")
	by vger.kernel.org with SMTP id <S130723AbRCEWTh> convert rfc822-to-8bit;
	Mon, 5 Mar 2001 17:19:37 -0500
From: davidge@jazzfree.com
Date: Tue, 6 Mar 2001 00:16:26 +0100 (CET)
To: Tania Gomes Ramos <tgomesr@silver.udg.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems installing the kernel 2.4 (fwd)
In-Reply-To: <Pine.GSO.4.31.0103052224570.29920-100000@silver.udg.es>
Message-ID: <Pine.LNX.4.21.0103060013250.2181-100000@roku.redroom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Mar 2001, Tania Gomes Ramos wrote:

Have you updated your modutils? Maybe that's why it's not working your
network adapter. If you didn't, take a look at
/usr/src/linux/Documentation/Changes to find out with versions do you need
to run a 2.4 kernel.


> 
> 
>    First of all, thanks for helping me...
>    I have noticed that after I have installed the new version
>  of kernel (2.4.2),I am having some problems... After compiling
> everything, and making the make install_modules, I have the message that
> there is nothing to be done in the directories... But, ok, it creates
> the modules directorie. But...
>    First of all,
>  1)  -- now, trying to acess the network is impossible ... the
> ifconfig just shows "lo"  and the ethernets no... but, they were
> configured in the lilo in the same way they were configured with
> the old kernel. You can see the configuration in the lilo:
> (there are two partitions, and I have installed the new kernel in
> the partition altres)
> 
> image= ../boot/vmlinuz.ip6
>          label=lr
>          append ="ether=5,0x300,eth0 ether=10, 0x210, eth1"
>          initrd=..boot/initrd-2.2.12-20.img
>          root=/dev/hda1
>          read-only
> 
> image= ../boot/vmlinuz-2.4.2
>          label=altres
>          append ="ether=5,0x300,eth0 ether=10, 0x210, eth1"
>          #initrd=..boot/initrd-2.2.12-20.img
>          root=/dev/hdc1
>          read-only
> 
> Well, I put a comment in front of initrd because I didnt find
> this file *.img of the new kernel...
> 
> I havent changed anything else, and my computer cant see the
> network in the partition altres, but in the other one,it is
>  possible.
> 
> 2)The other problem is:
>     After installing it, this partition (the only one which
> has version 2.4) cant reboot or halt. It starts to do that,
> but it always stops at the message:
> INIT: there is no more process left in this runlevel.
>  so,I always have to reset the computer...
> 
> Do you know why it is happening? And what could I do to fix it??
> 
> Thank you,
> Tania Ramos
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra


