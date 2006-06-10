Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161012AbWFJV3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbWFJV3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 17:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030509AbWFJV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 17:29:04 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:40414 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030508AbWFJV3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 17:29:03 -0400
Message-ID: <448B399D.7040703@free.fr>
Date: Sat, 10 Jun 2006 23:29:01 +0200
From: matthieu castet <castet.matthieu@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: fr-fr, en, en-us
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, linux-kernel@vger.kernel.org
Subject: Re: ACPI patch process problems again
References: <20060610164150.GR1651@parisc-linux.org> <pan.2006.06.10.20.51.12.109916@free.fr> <20060610211156.GT1651@parisc-linux.org>
In-Reply-To: <20060610211156.GT1651@parisc-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Matthew Wilcox wrote:
> On Sat, Jun 10, 2006 at 10:51:13PM +0200, Matthieu CASTET wrote:
> 
>>Le Sat, 10 Jun 2006 10:41:50 -0600, Matthew Wilcox a ?crit?:
>>
>>>ACPI ADDRESSn resources can describe both memory and port io, but the
>>>current code assumes they're descibing memory, which isn't true for HP's
>>>ia64 systems.
>>>
>>
>>There already a patch for that in -mm kernel
> 
> 
> Yes, the original author just contacted me to tell me.  It seems to me
> that we have a process problem when a bug gets fixed on March 28th,
> but not propagated upstream by June 10th.  That's almost 11 weeks,
> and I'm sure it'll be more by the time it's finally merged.  I thought
> the days of ACPI process problems were behind us ;-(

The problem is that this patch (and your patch) introduce a regression 
for some boxes.

See http://bugzilla.kernel.org/show_bug.cgi?id=6292 for more info.

I submited today a fix for this regression.

Matthieu
