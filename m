Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265074AbUHJND2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265074AbUHJND2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 09:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265099AbUHJNC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 09:02:58 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3333 "EHLO
	smtp-vbr4.xs4all.nl") by vger.kernel.org with ESMTP id S265074AbUHJNAH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 09:00:07 -0400
Date: Tue, 10 Aug 2004 14:59:32 +0200
From: Jurriaan <thunder7@xs4all.nl>
To: "Tony \(Unihost\)" <tony@unihost.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APIC Error 04(04) Kernel Breakage
Message-ID: <20040810125932.GA1429@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <4118B849.9070202@unihost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4118B849.9070202@unihost.net>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony (Unihost) <tony@unihost.net>
Date: Tue, Aug 10, 2004 at 12:58:01PM +0100
> The Mobo in question is an Asus A7M266-D, currently running the latest 
> BIOS and a pair of MP1600 Procs.  All is functioning well (apart from 
> crashes from the AACRAID driver)  I'm runnning Kernel 2.6.3.   It is a 
> production server which makes debugging all the more difficult.
> 
> When the server was taken down a week or two ago for an upgrade, two AMD 
> MP2800 processors were installed.  Upon reboot there was a flood of /
> 
> "APIC error on CPU0: 04(04)"
> 
I seem to remember a post not too long ago on this list where problems
like this were solved by a bios update to the latest bios.

Try searching lkml-archives for a post titled 'Asus A7M266-D,
linux-2.6.7 and APIC' of the 20th July 2004.

I'll quote a relevant part here:

>>Date: Wed, 21 Jul 2004 19:53:13 -0700 (PDT)
>>From: Andy Biddle <andybXchainsaw.com>
>>To: linux-kernelXvger.kernel.org
>>Subject: Re: Asus A7M266-D, Linux 2.6.7 and APIC
>>
>>
>>Mikael,
>>
>>You were absolutely right.  There was an update that I couldn't see from
>>the website.  Even better news is that it totally solved my problem.  No
>>APIC problems at all now!
>>
>>Thanks a TON for the help!
>>
>>
>>On Wed, 21 Jul 2004, Mikael Pettersson wrote:
>>
>>> On Wed, 21 Jul 2004 08:46:11 -0700 (PDT), Andy Biddle wrote:
>>> >Well I had a few minutes this morning, so I swapped CPU0 and 1 and still
>>> >have the same results.  Boots in single proc mode, APIC errors on a
>>> >dual-proc kernel.  (For what it's worth, both CPUs are recognized by the
>>> >BIOS and report "MP capable".
>>> >
>>> >I checked the Asus website and I'm at the latest beta kernel...
>>>
>>> No you're not. You have 1011.003, while the latest beta BIOS
>>> is 1011 beta 05.
>>>
>>> ftp.asuscom.de
>>> pub/ASUSCOM/BIOS/Socket_A/AMD_Chipset/AMD_760_MPX/A7M266-D/

Good luck, and next time search the archives :-)

Jurriaan
-- 
> No manual is ever necessary.
May I politely interject here: BULLSHIT.  That's the biggest Apple lie of all!
	Discussion in comp.os.linux.misc on the intuitiveness of interfaces
Debian (Unstable) GNU/Linux 2.6.8-rc4-mm1 2x6078 bogomips load 0.03
