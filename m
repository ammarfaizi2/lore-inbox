Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266547AbUGPNRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUGPNRr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 09:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUGPNRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 09:17:47 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:3769 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S266547AbUGPNRo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 09:17:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: New mobo question
Date: Fri, 16 Jul 2004 09:17:42 -0400
User-Agent: KMail/1.6
References: <200407160552.27074.gene.heskett@verizon.net> <20040716112007.GA14641@taniwha.stupidest.org>
In-Reply-To: <20040716112007.GA14641@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407160917.42442.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [141.153.127.68] at Fri, 16 Jul 2004 08:17:43 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 July 2004 07:20, Chris Wedgwood wrote:
>On Fri, Jul 16, 2004 at 05:52:27AM -0400, Gene Heskett wrote:
>> I've ordered a new mobo as I'm having what appears to be data bus
>> problems with this one after a rather spectacular failure of a
>> gforce2 video card, memtest86 says I have a lot of errors where
>> 00000020 was written, but 00000000 came back, at semi-random
>> locations scattered thoughout half a gig of dimms running at half
>> their rated DDR266 speed.  The last nibble of the address is
>> always zero, and the next nibble is always even.
>
>Get the board replaced.
>
Its ordered from tcwo.  Along with a gig of DDR400 ram, & a new cooler 
for a fresh athlon 2800 XP.  This old 1400 has been cooking along at 
or above 70C for 3 years, 24/7/365.

>> Is there a way to prebuild a kernel that will run on both boards?,
>> this older board is a VIA82686/VIA8233 based board, a Biostar
>> M7VIB.

I guess I've answered my own question, I'm now running a 2.6.8-rc1-mm1 
kernel that has the AMD/nforce IDE stuff built in along with the VIA.  
dmesg says nothing at all about the presense of the nforce stuff.  I 
would have thought it might have tossed a line or 2 of "can't find my 
chipset" messages, but nothing came out.

I assume thats the correct drivers for an nforce2 board?

How about the ethernet on that Biostar M7NCD-PRO board, what driver 
does it need?  Currently running the 8139too.

Those are the important things, I can sort the usb & audio another 
day.

>If I read you correctly you're getting random corruptions all over
> the place so there isn't much you an do.

The strangest things are happening, like a rebuild of kde3.2.3 always 
stops with a bus error on the exact same output file.  Yum has died, 
with a python error from libxml2, and the whole python install has 
been upgraded without bothering the error.  Ditto for libxml2.

And kde3.2 occasionally forgets its filters, or changes fonts and or 
font sizes at random.

>
>  --cw
Thanks for the reply, its appreciated.

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.
