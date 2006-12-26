Return-Path: <linux-kernel-owner+w=401wt.eu-S1754601AbWLZBP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbWLZBP4 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 25 Dec 2006 20:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbWLZBP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Dec 2006 20:15:56 -0500
Received: from mail-placeholder.iinet.net.au ([203.59.1.163]:46566 "EHLO
	customer-domains.icp-qv1-irony13.iinet.net.au" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754601AbWLZBP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Dec 2006 20:15:56 -0500
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Dec 2006 20:15:55 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgAAAL4EkEXLO9kWUGdsb2JhbAANjXIBASo
X-IronPort-AV: i="4.12,210,1165161600"; 
   d="scan'208"; a="71577626:sNHT14789187"
Message-ID: <4590756F.1090603@mobily.com>
Date: Tue, 26 Dec 2006 10:05:51 +0900
From: Tony Mobily <merc@mobily.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Greg Kroah-Hartman <gregkh@suse.de>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Putting the sdhci to sleep safely [with attachments]
References: <458FA64E.7070501@mobily.com> <20061225211432.GA2460@elf.ucw.cz>
In-Reply-To: <20061225211432.GA2460@elf.ucw.cz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> (Please always cc: linux-kernel@ with such stuff).

Gosh, alright. I am gonna embarrass myself here, but I guess this is
part of the game...! :-D

>> I am the Editor In Chief of Free Software Magazine
>> (http://www.freesoftwaremagazine.com)
>> I am in a bit of a mission: I would like to see the module sdhci put my
>> card reader to sleep without getting the system highly
>> unstable. This is
> 
> Well, suspend works for me, and my machine seems to have sdhci:
> 
> 0000:15:00.2 0805: Ricoh Co Ltd R5C822 SD/SDIO/MMC/MS/MSPro Host
> Adapter (rev 18)

Alright, that's what I have as well...

0a:01.1 Generic system peripheral [0805]: Ricoh Co Ltd R5C822
SD/SDIO/MMC/MS/MSPro Host Adapter (rev 19)

>> Pierre Ossman, the maintainer of the sdhci module, wrote to me:
>>
>> "Anyway, as far as I know, this isn't a bug in the driver, so there is
>> not very much I can do. The problem is somewhere in the PCI interaction,
>> but I've sent numerous mail to the kernel PCI hackers, but have yet to
>> receive a single reply."
> 
> I've certainly not seen such a mail. 

OK. I guess there was a bit of a communication problem here. I am more
than happy to

> Can you get info what is wrong
> with that, and cc lkml, me and greg?

Sure thing!

>> So, here I am... please find attache my lspci and the log of what
>> happens when the computer is put to sleep.
>>
>> I would also be happy to organise a bounty for this bug to be fixed.
> 
> :-). Just hunt it yourself. It is probably easier than organizing a bounty.

OK. I had a look at the code, and I foind it depressing. Not because it
was bad, but because it reminded me of how hopeless I am!
I can do my best to get you guys to communicate, *and* to get some
testing done - I am more than happy to spend as long as it takes
testing, compiling patches, and putting my laptop to sleep over and over
and over again. But coding... nope. Not on *this* code...

> Ouch... you failed to mention what kernel you are using?

I told you I'd embarrass myself...

Linux merc-laptop 2.6.19-7-generic #2 SMP Mon Dec 4 16:46:19 UTC 2006
i686 GNU/Linux

I am trying to gather some information - will report back to you ASAP.

Merc.
