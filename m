Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031867AbWLGJDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031867AbWLGJDj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 04:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031873AbWLGJDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 04:03:39 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:56137 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031870AbWLGJDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 04:03:37 -0500
Message-ID: <4577D8F9.90302@citd.de>
Date: Thu, 07 Dec 2006 10:03:53 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <fa./xvi+/Ji/HqNkvnGjUt4pIS9goM@ifi.uio.no> <45775A32.2050506@shaw.ca>
In-Reply-To: <45775A32.2050506@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> Matthias Schniedermeyer wrote:
>> Hi
>>
>>
>> I'm using a Bunch auf HDDs in USB-Enclosures for storing files.
>> (currently 38 HDD, with a total capacity of 9,5 TB of which 8,5 TB is
>> used)
> 
> All the same enclosure type?

36x"Fantec (was MaPower) DB-335U2-1" with Genesys-Logic-Chipset (at
least the model i used yesterday said that. I bought this 36 enclosures
in the time from May/2005 - October/2006, so it is possible that they
use different chipsets and/or revisions of the chipset)
2x"IOmega 33644" bought last week, with a Chipset that says it is from
IOMega, but i guess it is just a rebranded.
I have errors with all of them.

I have a spare enclosure Fantec DB-35U2-2, AFAICT it uses a
Cypress-Chipset which i haven't used for some time, so ATM i don't
remember if i had it with this one too.


>> This time i kept the defective files and used "vbindiff" to show me the
>> difference. Strangly in EVERY case the difference is a single bit in a
>> sequence of "0xff"-Bytes inside a block of varing bit-values that
>> changed a "0xff" into a "0xf7".
>> Also interesting is that each error is at a 0xXXXXXXX5-Position
>>
>> Attached is a file with 5 of the 6 differences named 1-5. Of each of the
>> 5 2x3 lines-blocks the first 3 lines are the original the following 3
>> lines contain the error in the middle row 6th value.
>>
>> NEVER did i see any messages in syslog regarding erros or an aborting
>> program due to errors passed down from the kernel or something like that.
> 
> The fact that the corruption seems data dependent would seem to me to
> point to some kind of hardware problem. I would tend to suspect the
> USB-to-IDE converters in the enclosures as being faulty or something
> like that..
> 


-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

