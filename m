Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274964AbRJUMMR>; Sun, 21 Oct 2001 08:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275973AbRJUML6>; Sun, 21 Oct 2001 08:11:58 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:55007 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S274964AbRJUMLx>; Sun, 21 Oct 2001 08:11:53 -0400
Date: Sun, 21 Oct 2001 14:10:18 +0200 (MEST)
From: Joerg Schilling <schilling@fokus.gmd.de>
Message-Id: <200110211210.f9LCAIl08971@burner.fokus.gmd.de>
To: schilling@fokus.gmd.de, vherva@niksula.hut.fi
Cc: cdwrite@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10ac10, cdrecord 1.9-6, Mitsumi CR-4804TE: lock up burning too large image
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From vherva@niksula.hut.fi Sun Oct 21 14:08:12 2001

>On Sun, Oct 21, 2001 at 01:56:06PM +0200, you [Joerg Schilling] claimed:
>> 
>> >Hmm. It used to work with 2.2-kernel. With too large image, it just gave an
>> >error.
>> 
>> I may only judge from information you provide, not from information you hide.

>I did say that in the original report:

>"It used to give a nice error when disk size was exceeded with 2.2.18pre19
>and a tad older cdrecord..."

Sorry, I seem have to miss this.

>> 1.10 is outdated too, please read
>> 
>> http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/problems.html

>Ok. I'll compile the newest from source.

>But do you think the too-large-image lock up might be cured with a newer
>cdrecord, or should is the kernel the prime suspect?

It least recent libscg versions include a workaround for an incorrect
Linux kernel return for a timed out SCSI command via ATAPI. So if the kernel 
does return at all, cdrecord will know why.

Jörg

 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.gmd.de		(work) chars I am J"org Schilling
 URL:  http://www.fokus.gmd.de/usr/schilling   ftp://ftp.fokus.gmd.de/pub/unix
