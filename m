Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130055AbRCDPwQ>; Sun, 4 Mar 2001 10:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130064AbRCDPwG>; Sun, 4 Mar 2001 10:52:06 -0500
Received: from [213.97.199.90] ([213.97.199.90]:772 "HELO roku.redroom.com")
	by vger.kernel.org with SMTP id <S130055AbRCDPv6> convert rfc822-to-8bit;
	Sun, 4 Mar 2001 10:51:58 -0500
From: davidge@jazzfree.com
Date: Sun, 4 Mar 2001 17:48:50 +0100 (CET)
To: Christian Hilgers <webmaster@server-side.de>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: DVD Problem
In-Reply-To: <001b01c0a4ae$6c236e60$3201a8c0@laptop>
Message-ID: <Pine.LNX.4.21.0103041745210.1038-100000@roku.redroom.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Mar 2001, Christian Hilgers wrote:

So you need to compile the kernel with UDF support , which is the
filesystem used in DVDs. As you said, iso9660 works, but only for the
first 650 mb. And after it take a look at www.linuxvideo.org and
www.videolan.org.

> Hi,
> 
> I'm trying to use the 2.4.1 Kernel but I have some troubles with my
> ATAPI Matsushita UJDA510 DVD (Intel 82371AB/EP PCI Bus Master IDE
> Controler).
> It works perfekt with CD-Rom but when I try to read a ISO 9660 DVD I got
> an error.
> 
> I can mount the DVD and I can list the complet content but I guess I
> can't access any File behind 650 MB.
> 
> e.g.
> 
> mount /cdrom
> $ cat /cdrom/blah/blah/INDEX
> cat: INDEX.german: Input/output error
> 
> The kernel log
> Mar  3 18:45:06 laptop kernel: VFS: Disk change detected on device
> ide1(22,0)
> Mar  3 18:45:10 laptop kernel: ISO 9660 Extensions: RRIP_1991A
> Mar  3 18:46:05 laptop kernel: attempt to access beyond end of device
> Mar  3 18:46:05 laptop kernel: 16:00: rw=0, want=2855480, limit=1052700
> 
> It also works well with a 2.2.14-SuSE Kernel.
> 
> Any hints.
> 
> Thanks
> Christian
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


