Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275861AbRJUL6G>; Sun, 21 Oct 2001 07:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275963AbRJUL5z>; Sun, 21 Oct 2001 07:57:55 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:6877 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S275861AbRJUL5k>; Sun, 21 Oct 2001 07:57:40 -0400
Date: Sun, 21 Oct 2001 13:56:06 +0200 (MEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200110211156.f9LBu6308916@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, vherva@niksula.hut.fi
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From vherva@niksula.hut.fi Sun Oct 21 13:46:25 2001

>On Sun, Oct 21, 2001 at 01:37:01PM +0200, you [Joerg Schilling] claimed:
>> 

>Thanks for the timely reply!

>> This must be a broken drive....

>Hmm. It used to work with 2.2-kernel. With too large image, it just gave an
>error.

I may only judge from information you provide, not from information you hide.

>> Don't use outdated cdrecord versions, I cannot support them!

>Ok. I updated to 1.10 from redhat rawhide, but as said it didn't work at all

1.10 is outdated too, please read

http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/problems.html

>with 2.2 ("failed to mmap /dev/null" or something) so I went back to 1.9. I

I cannot prevent you from broken Linux installations!

The linux kernel people still have propblems with interfaces and make thanges that
break binary compatibility when going to more recent Linux versions.
Why do you believe that a cdrecord that has been compiled on 2.4 will run on 2.2?

Linux needed close to 10 years to finally support mmap() (ther OS like SunOS
did this since 1987). Cdrecord's outoconf chooses the best interfaces of the OS.
SVS shared mem is outdated and badly implemented on Linux (too many restrictions).
mmap is the modern method to get shared memory but Linux didn't support is before
November 2000.



Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
