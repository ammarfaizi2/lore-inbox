Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285262AbRLFW3M>; Thu, 6 Dec 2001 17:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285261AbRLFW3K>; Thu, 6 Dec 2001 17:29:10 -0500
Received: from hitchcock.mail.mindspring.net ([207.69.200.23]:60937 "EHLO
	hitchcock.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S285262AbRLFW23>; Thu, 6 Dec 2001 17:28:29 -0500
From: joeja@mindspring.com
Date: Thu, 06 Dec 2001 17:28:18 -0500
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: Re: 2.4.x 2.5.x wishlist
Message-ID: <Springmail.105.1007677698.0.93399100@www.springmail.com>
X-Originating-IP: 4.20.162.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus my wish for 2.5.x.  It seems that the problem I am having maybe in the ide driver itself.  I searched the web on this a lot before I sent this to the list, and found a post from Alan Cox saying that this was a low priority.  

Joe

> I tried the patch on your site against 2.4.14, it helped, system still hung... 

Damn.  Lost interrupt is outside my code.  This lives in the ide driver 
proper and is probably relative toi the via82cxxx specific controller 
code that is deep voodoo from Andre.  I guess Andre/Jens have not found 
all the *funnies* in the buggy chipset.


> hdd lost interrupt
> 
> is there buffereing done in data transfers to disks?  


Yes, but at the FS level, not in clever driver level stuff.


> I.E. if I cp to a drive is the data transfered right away or is there a delay?
> 
> J
> 
> 
>>I have a patch out, and am trying to convince Marcelo to include it.  I 
>>*DO* know about this as I get lots of the mail complaining about it.  > If 
>>you are suffering, please try with the patch
>>
> 


-- 

Paul

Email: 
paul@paulbristow.net
Web: 
http://paulbristow.net
ICQ: 
11965223


