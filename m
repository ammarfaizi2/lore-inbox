Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130452AbRCGMtB>; Wed, 7 Mar 2001 07:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131053AbRCGMsl>; Wed, 7 Mar 2001 07:48:41 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:9735 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S130452AbRCGMse>;
	Wed, 7 Mar 2001 07:48:34 -0500
Date: Wed, 07 Mar 2001 13:47:41 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: scsi vs ide performance on fsync's
To: andre@linux-ide.org
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3AA62DED.A4F6A1B6@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick (andre@linux-ide.org) wrote on Wed Mar 07 2001 - 01:58:44 EST :

> On Wed, 7 Mar 2001, Jonathan Morton wrote: 
 
[ snip ]
 
 
> > >Since all OSes that enable WC at init will flush 
> > >it at shutdown and do a periodic purge with in-activity. 
> > 
> > But Linux doesn't, as has been pointed out earlier. We need to fix Linux. 
> 
> Friend I have fixed this some time ago but it is bundled with TASKFILE 
> that is not going to arrive until 2.5. Because I need a way to execute 
> this and hold the driver until it is complete, regardless of the shutdown 
> method. 

I don't understand 100%.
Is TASKFILE required to do proper write cache flushing ?

> > >Err, last time I check all good devices flush their write caching on their 
> > >own to take advantage of having a maximum cache for prefetching. 
> > 
> > Which doesn't work if the buffer is filled up by the OS 0.5 seconds before 
> > the power goes. 
> 
> Maybe that is why there is a vender disk-cache dump zone on the edge of 
> the platters...just maybe you need to buy your drives from somebody that 
> does this and has a predictive sector stretcher as the energy from the 
> inertia by the DC three-phase motor executes the dump. 

So where is a list of drives that do this ?
www.list-of-hardware-that-doesnt-suck.com is not responding ...
 
> Ever wondered why modern drives have open collectors on the databuss? 

no :-)


-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
