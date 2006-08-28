Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbWH1V6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbWH1V6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 17:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWH1V6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 17:58:32 -0400
Received: from mga03.intel.com ([143.182.124.21]:23221 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750971AbWH1V6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 17:58:32 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,177,1154934000"; 
   d="scan'208"; a="108756334:sNHT17682392"
Message-ID: <44F36123.1000406@intel.com>
Date: Mon, 28 Aug 2006 14:33:23 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Auke Kok <auke-jan.h.kok@intel.com>, jakub@redhat.com, davem@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, john.ronciak@intel.com,
       jesse.brandeburg@intel.com
Subject: Re: e1000 driver contains private copy of GPL... and modified one,
 too
References: <20060827082534.GA2397@elf.ucw.cz> <44F30B25.2030906@intel.com> <20060828162539.GC30105@elf.ucw.cz>
In-Reply-To: <20060828162539.GC30105@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Aug 2006 21:58:30.0507 (UTC) FILETIME=[192CE3B0:01C6CAED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>>> Okay, so modifications are not major: different address of free
>>> software foundation, completely different formatting, some characters
>>> added, and some characters removed. It no longer contains Linus'
>>> clarifications.
>>>
>>> --- LICENSE     2006-07-21 05:42:27.000000000 +0200
>>> +++ ../../../COPYING    2006-07-21 05:42:27.000000000 +0200
>>> @@ -1,128 +1,141 @@
> 
>>> Now... I believe nothing evil is going on, but having two slightly
>>> different copies of GPL in one source seems wrong, can we get rid of
>>> e1000 one?
>> I'll ask around here and see if this doesn't make people cringe. Meanwhile 
>> Pavel should examine sound/oss/COPYING and arch/sparc/lib/COPYING.LIB too :)
> 
> Hehe, okay, going after them.

After discussing this with John and Jesse we found that we want to do an update 
for all our drivers and fix the issue. I will send a patch later out that 
removes the LICENSE file and changes the header of the involved files. I will 
most likely have to do this for e100 and ixgb as well, so it will come a bit 
later than right away.

Thanks Pavel.

Cheers,

Auke
