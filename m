Return-Path: <linux-kernel-owner+w=401wt.eu-S1754660AbWLRV5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbWLRV5v (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 16:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbWLRV5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 16:57:51 -0500
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:45472 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754660AbWLRV5u (ORCPT
	<rfc822;<linux-kernel@vger.kernel.org>>);
	Mon, 18 Dec 2006 16:57:50 -0500
X-Greylist: delayed 1379 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 16:57:49 EST
Message-ID: <4587097D.5070501@opensound.com>
Date: Mon, 18 Dec 2006 23:34:53 +0200
From: Hannu Savolainen <hannu@opensound.com>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Open letter to Linux kernel developers (was Re: Binary Drivers)
References: <loom.20061215T220806-362@post.gmane.org> <200612162007.32110.marekw1977@yahoo.com.au>
In-Reply-To: <200612162007.32110.marekw1977@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Wawrzyczny wrote:
> Dear Linux Kernel ML,
>
> I am writing as a Linux-only user of over 2 years to express my concern with 
> the recent proposal to block out closed source modules from the kernel.
>
> While, I understand and share your sentiments over open source software and 
> drivers. I fear however, that trying to steamroll the industry into 
> developing open source drivers by banning closed source drivers is going to 
> have a completely different result. They will simply abandon Linux support 
> for some of their products altogether.
>   
As a developer of some "closed source" drivers I can confirm that this 
is exactly the case. I would never consider open sourcing my work just 
because somebody is pointing pistol to my neck. I would leave the whole 
IT business and start doing something else rather than accept this kind 
of mafia-like negotiation methods.

For a professional developer of any software the decision of open 
sourcing it is not easy. "Just for fun" developers have no problems 
because they don't expect to be able to live on their work anyway. 
However a professional developer can release software under GPL only if 
it's considered invaluable or if there is some way to guarantee 
sufficient income. Releasing something under GPL without a guaranteed 
backup plan is like jumping from an airplane without parasuit. If 
somebody forces me to jump form an airplane without a parasuit then what 
would this be called?

> The bottom line is that the proposed 1st Jan 2008 dead line is unlikely to 
> make any corporations tremble. It is likely to be the day when I will be no 
> longer able to run the latest version of the kernel.
To us this decision would mean that after Jan 1 2008 we will be out of 
business (at least in the Linux market). Due to the nature of our 
product (kernel level sound API) there is no alternative way to get USB 
working. We could try to develop an alternative API that is user land 
based but this is not going to work. We could also develop an artifical 
user land driver that would require application->kernel->deamon->kernel 
type looping which kills performance and causes massive latencies but it 
doesn't make any sense.

Our alternatives are to leave the Linux market or to release our code 
under GPL. GPLing means that we will have to give to the major Linux 
companies full rights to do whatever they like with our code. They will 
have complete freedom to adapt our product for their purposes and to 
sell it for profit. There is no law that would require them to pay 
anything to us. There is also no way we could compete with them because 
the current device/module model makes it completely impossible to ship 
precompiled binary modules for all possible kernel 
distributions/versions. At this moment only the companies controlling 
the Linux distributions can sell binary drivers.

Developers contributing their software to Linux kernel have full right 
to decide if other kernel code using their work is derived or not. 
However is it not fair that developers of some key subsystem like USB 
use this right? There is no alternative USB subsystem that the others 
could use. Of course we could take the earlier USB subsystem before the 
EXPORT_SYMBOL_GPL change and ship it together with our software. However 
is this going to work or is it benefit of anybody? No.

Using EXPORT_SYMBOL_GPL is fair to protect code such as checksum or 
encryption/decryption algorithms is fair. Developers of independent 
kernel modules can use their own code. But the USB subsystem is 
different case because there is no alternative.

Isn't it somehow suspicious if this kind of decisions are made by 
employees of companies that develop a product which directly competes 
with ours. Maybe this is the way how the free Linux community works.

I would suggest the Linux kernel developer community should write down 
some rules the developers should agree _before_ they contribute anything 
to the kernel. It's not good to anybody that different developers can 
set different rules for the usage of their code. In particular it's not 
good that anybody can put additional restrictions to 
subsystems/interfaces that have been freely usable for years. The rest 
of the IT industry can then examine the rules and decide if there is any 
idea in investing on Linux based products.

Best regards,

Hannu
