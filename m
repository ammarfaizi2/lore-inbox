Return-Path: <linux-kernel-owner+w=401wt.eu-S1750978AbXAKSPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXAKSPQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 13:15:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbXAKSPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 13:15:16 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:38720 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750978AbXAKSPO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 13:15:14 -0500
Date: Thu, 11 Jan 2007 19:01:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: Andreas Schwab <schwab@suse.de>, Roman Zippel <zippel@linux-m68k.org>,
       Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>,
       Olaf Hering <olaf@aepfle.de>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: .version keeps being updated
In-Reply-To: <2bb47a77ba69186f793f57b86c003ebd@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0701111857530.29801@yvahk01.tjqt.qr>
References: <20070109102057.c684cc78.khali@linux-fr.org>
 <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org>
 <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <20070110193136.GA30486@aepfle.de>
 <20070110200249.GA30676@aepfle.de> <Pine.LNX.4.61.0701102352400.28885@yvahk01.tjqt.qr>
 <acfe3f410c8bae877412655797a15e17@kernel.crashing.org>
 <Pine.LNX.4.61.0701111424390.29801@yvahk01.tjqt.qr> <jeejq1is77.fsf@sykes.suse.de>
 <2bb47a77ba69186f793f57b86c003ebd@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 11 2007 18:39, Segher Boessenkool wrote:
>
>> > ../drivers/char$ objcopy -j .modinfo -O binary sonypi.ko
>> > objcopy: stvfMiji: Permission denied
>> > 
>> > Why does it want to create a file there? This one works better:
>> 
>> objcopy works in-place when only one file argument is passed.
>
> Yeah.  The >(...) syntax in my example provides such a file;
> of course it's horribly broken in bash 3.x like so many other
> things, but that's a different issue ;-)

I took () to be substituted, did not know you intended to write >(grep ...)
And that's not broken at all.


	-`J'
-- 
