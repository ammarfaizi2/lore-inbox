Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132127AbRDNNAv>; Sat, 14 Apr 2001 09:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRDNNAc>; Sat, 14 Apr 2001 09:00:32 -0400
Received: from mp-216-40-25.daxnet.no ([193.216.40.25]:17959 "EHLO
	pilt.home.garstad.net") by vger.kernel.org with ESMTP
	id <S132127AbRDNNAZ> convert rfc822-to-8bit; Sat, 14 Apr 2001 09:00:25 -0400
Message-ID: <001201c0c4e2$d71e8b10$01000001@pompel>
From: "Ola Garstad" <olag@eunet.no>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>,
        "Arthur Pedyczak" <arthur-p@home.com>
In-Reply-To: <Pine.LNX.4.33.0104140843170.21879-100000@cs865114-a.amp.dhs.org>
Subject: Re: loop problems continue in 2.4.3
Date: Sat, 14 Apr 2001 14:58:50 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a tip:

I had the same problems when I started to use 2.4.x kernels. It was the compiler that caused the problem. 
I switch to using kgcc (comes with RH 7.0) and all the problems when away. :-)

----- Original Message ----- 
From: "Arthur Pedyczak" <arthur-p@home.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: "Linux kernel list" <linux-kernel@vger.kernel.org>; "Jeff Garzik" <jgarzik@mandrakesoft.com>
Sent: Saturday, April 14, 2001 2:46 PM
Subject: Re: loop problems continue in 2.4.3


> On Sat, 14 Apr 2001, Jens Axboe wrote:
> 
> [ SNIP..................]
> > > =====================
> > > Apr 13 20:50:03 cs865114-a kernel: Unable to handle kernel paging request at virtual address 7e92bfd7
> >
> > Please disable syslog decoding (it sucks) and feed it through ksymoops
> > instead.
> >
> > In other words, reproduce and dmesg | ksymoops instead.
> >
> >
> I tried to reproduce the error this morning and couldn't. Same kernel
> (2.4.3), same setup, same iso file. It mounted/unmounted 10 times with no
> problem. DOn't know what to think.
> 
> Arthur
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

