Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbVJEWyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbVJEWyY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030402AbVJEWyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:54:24 -0400
Received: from postman.ripe.net ([193.0.0.199]:53659 "EHLO postman.ripe.net")
	by vger.kernel.org with ESMTP id S1030401AbVJEWyX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:54:23 -0400
Message-ID: <4344599B.7060308@colitti.com>
Date: Thu, 06 Oct 2005 00:54:19 +0200
From: Lorenzo Colitti <lorenzo@colitti.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
References: <20051002231332.GA2769@elf.ucw.cz> <200510032339.08217.rjw@sisk.pl> <20051003231715.GA17458@elf.ucw.cz> <200510041711.13408.rjw@sisk.pl> <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz>
In-Reply-To: <20051005224418.GA22781@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-RIPE-Spam-Level: 
X-RIPE-Spam-Tests: ALL_TRUSTED,BAYES_05
X-RIPE-Spam-Status: U 0.473544 / -3.7
X-RIPE-Signature: 102d9dd9c2f98abfff3e939b1dac69cf
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
>> - It was dog slow because it doesn't use compression
>> - Even though it's dog slow, it doesn't save all RAM
>>   - Therefore the machine is dog slow after resume
>> - It doesn't have a decent UI
>> - There is no way to abort suspend once it's started. [...]
> 
> With uswsusp (aka swsusp3), you can do all this in userland. Stop
> whining, start hacking... Code is at kernel.org/git/.../linux-sw3.

But that was exactly my point: there's no need to hack!

The code is there. It's well tested, fast, stable, and does what users 
need. It's called suspend2. Why work on yet another implementation 
instead of just merging that?


Cheers,
Lorenzo

-- 
http://www.colitti.com/lorenzo/
