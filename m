Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbUCZPDR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbUCZPDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 10:03:17 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:30632 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263586AbUCZPDL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 10:03:11 -0500
Message-ID: <40644629.9090602@stesmi.com>
Date: Fri, 26 Mar 2004 16:03:05 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eduard Bloch <edi@gmx.de>
CC: David Schwartz <davids@webmaster.com>, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <20040325225423.GT9248@cheney.cx> <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com> <20040326131629.GB26910@zombie.inka.de> <40643BFA.1000302@stesmi.com> <20040326142917.GB30664@zombie.inka.de> <40644071.9090900@stesmi.com> <20040326145506.GA31759@zombie.inka.de>
In-Reply-To: <20040326145506.GA31759@zombie.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>>>The GPL does not talk about the code to create things, but code to
>>>_modify_ things. If you never have to modify the firmware file, where is
>>>the point?
>>
>>And if I feel like I _want_ to modify it? Then I should be entitled
>>to the preferred form to make modifications to it as is my right
>>under the GPL, regardless of if I a) want to b) have a need to
>>c) give a rat's ass about what the firmware does or does not do.
>>A binary blob is extremely seldom the preferred form to make
>>modifications to, even though some such cases do or might exist.
> 
> Same with WAV and PNG files distributed with many GPL packages. It is
> widely accepted method to distribute files that do not need modification
> without their "source" (whatever source is used to create them).

A WAV file can altered easily using any sound program that will in fact
produce an output that would "work" as would the same apply to a PNG
file. If the result would be pretty or not is a different question
of course :)

To draw a parallel between a WAV or PNG file (a well-known standard)
to a firmware for a specific card (a closed standard) is thin.

Even though I can modify a PNG or WAV file using a hex editor it
is _NOT_ preferred form, and neither is modifying the firmware
using a hex editor, neither to me nor to the people doing the cards.

>>You do know that certain TV cards (using the ivtv driver) lack a rom
>>and needs a firmware initialized during startup just like this example.
>>
>>Why am I taking this up ? Well they have specifically stated that the
>>firmware _may not be used without the windows driver_ even though
>>others have written a fully working driver that _only_ needs the
>>firmware from the windows driver to function under linux.
> 
> Write a firmware loader that extracts it from the Windows DLLs. Such
> things happened in the past and work AFAIK quite good.

Yes, but the legality of it is questionable.

>>Surprised? If they put the firmware on the card (rom/flash/eeprom)
> 
> No.
> 
>>this wouldn't have happened but it did.
>>How exactly do you believe this makes anything more flexible for me
>>as an end user when it is not LEGAL for me to use the card with
>>linux due to the firmware issue.
> 
> Imagine, there is a bug in the firmware. Normaly, you would have to boot
> windows or DOS to run a flash tool to install it into the device. Here
> you just replace the DLL.

You mean get a new DLL and decompile it or otherwise gain access
to said firmware.

>>Yes, some claim there IS a loophole in that the end user MAY extract
>>the firmware from the windows driver himself and use it together
>>with the (open) linux driver but IANAL. Ie use but not redistribute.
> 
> The user gets the driver CD when he buys the hardware.

Some countries might call it illegal to use the contents to other
uses than  issued but a country like germany for instance would
I believe invalidate the license since it was not accepted before
purchase, so the whole thing is very iffy. Again, IANAL.

// Stefan
