Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263954AbUCZOi5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 09:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUCZOi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 09:38:56 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:18088 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263954AbUCZOiv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 09:38:51 -0500
Message-ID: <40644071.9090900@stesmi.com>
Date: Fri, 26 Mar 2004 15:38:41 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eduard Bloch <edi@gmx.de>
CC: David Schwartz <davids@webmaster.com>, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <20040325225423.GT9248@cheney.cx> <MDEHLPKNGKAHNMBLJOLKCEEOLEAA.davids@webmaster.com> <20040326131629.GB26910@zombie.inka.de> <40643BFA.1000302@stesmi.com> <20040326142917.GB30664@zombie.inka.de>
In-Reply-To: <20040326142917.GB30664@zombie.inka.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

>>>Yes, the driver authors PREFERS to make the changes on the C source
>>>code, he never has to modify the firmware. Exactly what the GPL
>>>requests, where is your problem?
>>
>>But the firmware didn't appear out of thin air - someone wrote it
>>somehow. If that's using a hex editor or inside the C code doesn't
> 
> The GPL does not talk about the code to create things, but code to
> _modify_ things. If you never have to modify the firmware file, where is
> the point?

And if I feel like I _want_ to modify it? Then I should be entitled
to the preferred form to make modifications to it as is my right
under the GPL, regardless of if I a) want to b) have a need to
c) give a rat's ass about what the firmware does or does not do.
A binary blob is extremely seldom the preferred form to make
modifications to, even though some such cases do or might exist.

> I do not see a big difference between firmware data stored in a flash
> rom inside of the hardware part and the same data loaded during the
> driver initialisation. In contrary, it saves money and makes things more
> flexible. You should thank your hardware manufacturer instead of
> bitching about bogus things.

You do know that certain TV cards (using the ivtv driver) lack a rom
and needs a firmware initialized during startup just like this example.

Why am I taking this up ? Well they have specifically stated that the
firmware _may not be used without the windows driver_ even though
others have written a fully working driver that _only_ needs the
firmware from the windows driver to function under linux.

Surprised? If they put the firmware on the card (rom/flash/eeprom)
this wouldn't have happened but it did.
How exactly do you believe this makes anything more flexible for me
as an end user when it is not LEGAL for me to use the card with
linux due to the firmware issue.

Yes, some claim there IS a loophole in that the end user MAY extract
the firmware from the windows driver himself and use it together
with the (open) linux driver but IANAL. Ie use but not redistribute.

Now, just to make it perfectly clear - I am not debating wether
firmware should be GPL or not - I couldn't care less to be honest.
I am simply answering some claims that I myself find bogus.

// Stefan
