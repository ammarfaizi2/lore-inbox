Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRBMTL7>; Tue, 13 Feb 2001 14:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129661AbRBMTLu>; Tue, 13 Feb 2001 14:11:50 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:19972 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S129604AbRBMTLn>; Tue, 13 Feb 2001 14:11:43 -0500
Message-ID: <009401c095f1$83b04c40$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>, <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
In-Reply-To: <Pine.Linu.4.10.10102130916110.805-100000@mikeg.weiden.de> <005e01c095f0$6c1b6c00$bba6b3d0@Toshiba>
Subject: Re: Problem with Ramdisk in linux-2.4.1 
Date: Tue, 13 Feb 2001 11:16:43 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mike and others ,

Sometimes i also get :-

incomplete literal tree
OR
incomplete distance tree

along with

invalid compressed format (err=1)
OR
invalid compressed format (err=2)
OR
crc error

And it is very strange because for the same ramdisk , linux2.4.1 shows me
all the error messages .

I am using Ramdisk of 8 MB on compression it becomes around 1.4 MB.

Please help me.

Thanks ,

Best Regards,

 Jaswinder.
 --
 These are my opinions not 3Di.


----- Original Message -----
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: "Mike Galbraith" <mikeg@wen-online.de>; <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Sent: Tuesday, February 13, 2001 11:08 AM
Subject: Re: Problem with Ramdisk in linux-2.4.1


> Dear Mike and others ,
>
> I am using compressed ramdisk , i can not turn off cramfs .
>
> my error messages are very strange and irreregular .
>
> i am getting 3 different kind of error messages :-
>
> invalid compressed format (err=1)
> OR
> invalid compressed format (err=2)
> OR
> crc error
>
> I am using gzip 1.2.4 (18 Aug 93)
>
> But when i use same ramdisk with old kernel like 2.2.12 , it works fine .
>
> Please help me.
>
> Thanks ,
>
> Best Regards,
>
> Jaswinder.
> --
> These are my opinions not 3Di.
>
> ----- Original Message -----
> From: "Mike Galbraith" <mikeg@wen-online.de>
> To: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
> Sent: Tuesday, February 13, 2001 12:22 AM
> Subject: Re: Problem with Ramdisk in linux-2.4.1
>
>
> > On Mon, 12 Feb 2001, Jaswinder Singh wrote:
> >
> > > Dear linux-kernel mailing list,
> > >
> > > I am facing this problem in linux-2.4.1 :-
> > >
> > > RAMDISK driver initialized: 16 RAM disks of 8192K size
> > > 1024 blocksize
> > > RAMDISK: Compressed image found at block 0
> > >  incomplete distance tree
> > > invalid compressed format (err=1)Freeing initrd
> > > memory: 4096k freed
> > >
> > > Is any body seen this problem earlier , any hint .
> >
> > Hi,
> >
> > I think I might have seen this problem before.  If this isn't
> > a cramfs initrd, turn off cramfs and I think it'll work right.
> > I once had cramfs on by accident, and I found that my initrd
> > wouldn't load.
> >
> > -Mike
> >
>

