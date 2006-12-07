Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163580AbWLGW5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163580AbWLGW5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163583AbWLGW5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:57:20 -0500
Received: from enyo.dsw2k3.info ([195.71.86.239]:45089 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163580AbWLGW5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:57:18 -0500
Message-ID: <45789C43.9020109@citd.de>
Date: Thu, 07 Dec 2006 23:57:07 +0100
From: Matthias Schniedermeyer <ms@citd.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
Cc: linux-kernel@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: single bit errors on files stored on USB-HDDs via USB2/usb_storage
References: <45773DD2.10201@citd.de> <20061207221015.GA342@DervishD>
In-Reply-To: <20061207221015.GA342@DervishD>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>     Hi Matthias :)
> 
>  * Matthias Schniedermeyer <ms@citd.de> dixit:
> 
>>My averate file size is about 1GB with files from about 400MB to
>>5000MB I estimate the average error-rate at about one damaged file in
>>about 10GB of data.
>>
>>I'm not sure and haven't checked if the files are wrongly written or
>>"only" wrongly read back as i delete the defective files and copy them
>>again.
>>
>>Today i copied a few files back and checked them against the stored MD5
>>sums and 5 files of 86 (each about 700 MB) had errors. So i copied the 5
>>files again. 4 of the files were OK after that and coping the last file
>>the third time also resulted in the correct MD5.
> 
> 
>     I had more or less the same issue a week or two ago. I performed
> lots of tests and only by replacing the USB2.0 PCI card, the USB cable
> and the power supply of the usb-hdd adapter got the problem solved.
> 
>     I'm not sure if the problem is really gone, but the system works now
> reliably. I don't know if sooner or later I'll get the issue again,
> because I didn't really identify a culprit: looks like the
> card+adapter+cable combination was just "ugly", and errors from the
> adapter were not reported correctly.

The 38 HDDs are in 38 enclosures, so each has it's own power supply. I
have used different cables and i replaced the USB-Controller once.

So it can't be a single faulty component. Except when the computer
itself would be the culprit.

>>NEVER did i see any messages in syslog regarding erros or an aborting
>>program due to errors passed down from the kernel or something like
>>that.
>
>     The same here! Looks like USB-HDD adapters don't report any errors
> to the kernel :?????
> 
>     The best advice I can give you, from my limited experience with the
> problem, is: replace the cable. This minimizes the chance of corrupted
> data getting into the adapter. If that doesn't solve the problem, try
> removing any unconnected cable that is plugged into the USB card.
> Believe it or not, a long but unconnected cable (put there just to be
> able to plug my USB card-reader without having to look for the cable in
> a drawer) was causing errors *even in a Kingston USB key that worked
> flawlessly otherwise*!!!

Hmmm. That's the only thing that i currently may be doing wrong.
I have a 1,5 Meter and a 4,5 Meter cable connected to the USB-Controller
and i only use of them depending on where the HDD is placed in my room,
the other one is dangling unconnected.

Then i will unconnect the short cable and use the long cable exclusivly
and see if it gets better(tm).

>     If you have any other question, feel free to drop me a note. I'm
> sorry I cannot give a much more technical or scientific answer, but
> unfortunately I have none :((

Thank you anyway.





Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated,
cryptic, powerful, unforgiving, dangerous.

