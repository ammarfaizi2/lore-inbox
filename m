Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266520AbRGJPNQ>; Tue, 10 Jul 2001 11:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266544AbRGJPNG>; Tue, 10 Jul 2001 11:13:06 -0400
Received: from [208.187.172.194] ([208.187.172.194]:44810 "HELO
	odin.oce.srci.oce.int") by vger.kernel.org with SMTP
	id <S266520AbRGJPMy>; Tue, 10 Jul 2001 11:12:54 -0400
Message-ID: <3B4B1AFB.1090506@srci.iwpsd.org>
Date: Tue, 10 Jul 2001 09:10:51 -0600
From: "Joshua M. Schmidlkofer" <menion@srci.iwpsd.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2+) Gecko/20010709
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux kernel Development Mailing List 
	<linux-kernel@vger.kernel.org>
Subject: 2.4.6-preX, 2.4.6...
Content-Type: multipart/mixed;
 boundary="------------090707040500070600060202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090707040500070600060202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a strange problem, and I browsed the archives, but I don't see it 
being reported.  [God, what's the point.?  It's probably far too 
ambiguous to be useful.]

My System
HP Vectra VL8, 128 Ram, pIII 500, Matrox G200 [embedded], 2 Twelve-gig 
IDE drives.
Redhat 7.1 [Although, I don't think it matters]

I am using 'kgcc' [a.k.a. egcs-2.91.66] for compiling the kernel.

I have not located exactly [in which patch] the problem began, but if 
try to boot w/2.4.6-preX - 2.4.6,  the video goes away. And then it 
seems to lock up the computer.   At first I had APGART + DRI + MatroxFB. 
  So I removed the FB drivers, and tried again.   Same problems.   So I 
modularized Agpart, and DRI, [I need them for my X config].  No Change. 
  Almost immediatly after 'Uncompressing Linux.....'   I see a rush of 
the text across the screen, and then the screen flashes, and blinks, and 
then nothing.   I do not even have a  chance to see anything at all.  

I can't tell what's locking up, I tried a SysRQ, but got nothing.   No 
screen. *sigh*   I am not equiped to do this over a serial or parallel 
port.   I was hoping that someone would have a clue.  

In the mean time, I am expirimenting with different things. [kernel 
config's]   I will try to narrow it to a pre-release from 6.


thanks,
   Joshua

--------------090707040500070600060202
Content-Type: application/octet-stream;
 name="2.4.6.config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="2.4.6.config.bz2"

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
vEQCTTZr5cqWrvX6VgP+LuSKcKEhe23E3g==
--------------090707040500070600060202--

