Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154785AbQDYNxs>; Tue, 25 Apr 2000 09:53:48 -0400
Received: by vger.rutgers.edu id <S154873AbQDYNx2>; Tue, 25 Apr 2000 09:53:28 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:54662 "EHLO mailhub.fokus.gmd.de") by vger.rutgers.edu with ESMTP id <S154758AbQDYNxS>; Tue, 25 Apr 2000 09:53:18 -0400
Date: Tue, 25 Apr 2000 15:57:05 +0200 (MET DST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200004251357.PAA26880@fokus.gmd.de>
To: linux-kernel@vger.rutgers.edu, schilling@fokus.gmd.de, tmolina@home.com
Cc: ryanw@infohwy.com
>Subject: Re: errors while reading the last track of an audio cd with 2.3.X
Sender: owner-linux-kernel@vger.rutgers.edu

>From schilling@fokus.gmd.de Tue Apr 25 15:35:31 2000


>>From tmolina@home.com Mon Apr 24 20:13:35 2000
>>[1.] One line summary of the problem:
>>I receive errors while reading the last track of an audio cd with 2.3.X

>>[2.] Full description of the problem/report:
>>Following is the output from cdda2wav under 2.3.X kernels.  This is a
>>continuing problem with 2.3.47 and later versions.  This does not happen
>>with 2.2.14 and earlier.  It always gets to 99 percent, then shows an
>>error.  It happens on all audio CDs I've tested.

>>[root@wr5z rw1]# cdda2wav -B -D/dev/cdrom -Ocdr -t14 track14
>>cdrom device (/dev/cdrom) is not of type generic SCSI. Setting interface
>>to cooked_ioctl.

>Using the IOCTL is not a good idea. As it is non portable, it is not
>tested well.

>It also looks as if the kernel driver don't know as much as 
>mkisofs about different drives.
^^^^^
Sorry, should read cdda2wav ;-)




Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
