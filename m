Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272607AbRHaFPb>; Fri, 31 Aug 2001 01:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272608AbRHaFPV>; Fri, 31 Aug 2001 01:15:21 -0400
Received: from imo-r09.mx.aol.com ([152.163.225.105]:25804 "EHLO
	imo-r09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S272607AbRHaFPE>; Fri, 31 Aug 2001 01:15:04 -0400
From: Floydsmith@aol.com
Message-ID: <e4.1a14f481.28c07763@aol.com>
Date: Fri, 31 Aug 2001 01:15:15 EDT
Subject: Re2: ATAPI Floppy Problem - not bogas with ls-120 2.4.9
To: mrsam@courier-mta.com, linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>John Weber writes: 

>>> I get the following error on reboot... 
>>> 
>>> Aug 30 02:31:17 boolean kernel: ide-floppy: hdc: I/O error, pc = 5a, key 
= 
>>>  5, asc = 24, ascq =  0 
>>> 
>>> I have a ZIP 100, and am currently using ide-floppy driver 0.97 (included 
>>> with linux 2.4.9). 
>> 
>> Suggestions?

>This should be fixed in -ac4.  It's a bogus message.  Ignore it. 

>What is the vendor identification on this unit? 


>-- 
>Sam 

>-


This message is not a bogas message with ls-120 drives in 2.4.9. No problem 
occurs in 2.4.8. And, no problem occurs in 2.4.9 if the ide-floppy.c and 
ide.c from 2.4.8 replace the ones in 2.4.9. But, if the 2.4.9 kernel is built 
as is, then message appears on boot up and on attempting to mount a ls-120 
diskette even if a disketee is in the drive!

Floyd,
