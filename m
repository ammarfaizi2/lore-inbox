Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284413AbRLEOIv>; Wed, 5 Dec 2001 09:08:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284414AbRLEOIm>; Wed, 5 Dec 2001 09:08:42 -0500
Received: from barn.holstein.com ([198.134.143.193]:53002 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S284413AbRLEOIb>;
	Wed, 5 Dec 2001 09:08:31 -0500
Date: Wed, 5 Dec 2001 09:05:33 -0500
Message-Id: <200112051405.fB5E5X800353@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: alan@lxorguk.ukuu.org.uk
Cc: todd_m_roy@yahoo.com, linux-kernel@vger.kernel.org
In-Reply-To: <E16BJ85-0002iE-00@the-village.bc.nu> (message from Alan Cox on
	Tue, 4 Dec 2001 17:13:13 +0000 (GMT))
Subject: Re: Linux 2.4.17-pre2 (fwd)
Reply-To: troy@holstein.com
In-Reply-To: <E16BJ85-0002iE-00@the-village.bc.nu>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 12/05/2001 09:05:50 AM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 12/05/2001 09:05:51 AM,
	Serialize complete at 12/05/2001 09:05:51 AM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  X-Apparently-To: todd_m_roy@yahoo.com via web13604.mail.yahoo.com; 04 Dec 2001 09:04:18 -0800 (PST)
>  X-Track: 1: 40
>  Date: Tue, 4 Dec 2001 17:13:13 +0000 (GMT)
>  Cc: todd_m_roy@yahoo.com
>  Reply-To: alan@lxorguk.ukuu.org.uk
>  From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>  
>  > Could you please take a look at this? 
>  
>  Will do - it doesnt look remotely possibly related except as a bad compile
>  but stranger things have happened.
>  
>  > It worked fine for 2.4.16 and 2.4.17-pre1 and works fine
>  > again when I replaced 2.4.17-pre2's ad1848.c source with 2.4.16's ad1848.c
>  > and recompiled.
>  
>  Ok
>  
>  > this is what I get with the "bad" ad1848.o when I try to load esd:
>  
>  Can you strace esd and send me the strace output
>  

Alan,
  additional tidbit:
isapnp reports the sound chip to be a CS4236B, also I added
a printk to the bottom of ad1848.c 's init function that reports
the same thing.

-- todd --
