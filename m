Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130355AbQKVQPi>; Wed, 22 Nov 2000 11:15:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131826AbQKVQPT>; Wed, 22 Nov 2000 11:15:19 -0500
Received: from blackhole.compendium-tech.com ([206.55.153.26]:19183 "EHLO
        sol.compendium-tech.com") by vger.kernel.org with ESMTP
        id <S130355AbQKVQPP>; Wed, 22 Nov 2000 11:15:15 -0500
Date: Wed, 22 Nov 2000 07:44:59 -0800 (PST)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
To: Vincent <dtig@ihug.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount /mnt/cdrom ok!but ls segmentation fault...
In-Reply-To: <3A178406.1B0A1C8D@ihug.com.au>
Message-ID: <Pine.LNX.4.21.0011220742580.3799-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2000, Vincent wrote:
> Using linux-2.4.0-test11-pre7 right now..., here's what i did,
> mount /mnt/cdrom
> cd /mnt/cdrom
> ls
> Segmentation fault
> ls
> *NOT Responding....*
> can't kill /sbin/ls
> can't umount /mnt/cdrom
> ps , shows ;
> 
> 613 ?        D      0:00 /bin/ls --color=auto -F -b -T 0
>            ^^^^^
> 
> i didn't want to reboot...
> CDRom door is locked..
> 
> BTW, what does D mean in ps?

It's somewhat comforting to know that someone else has the same problem as
I do. I'd be willing to bet that he's using SCSI hostadapter emulation
with this. I am, and it only started happening as soon as I enabled
it. Any ideas? I need the sg stuff for my CD recorder to work properly...

 Kelsey Hudson                                           khudson@ctica.com 
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
