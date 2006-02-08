Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161074AbWBHI1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbWBHI1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 03:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161071AbWBHI1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 03:27:50 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:17117 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1161074AbWBHI1t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 03:27:49 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: David Chow <davidchow@shaolinmicro.com>
Subject: Re: Linux drivers management
Date: Wed, 8 Feb 2006 10:26:41 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060207044204.8908.qmail@science.horizon.com> <m1zml3rvkg.fsf@ebiederm.dsl.xmission.com> <43E8F8EB.8010800@shaolinmicro.com>
In-Reply-To: <43E8F8EB.8010800@shaolinmicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081026.41487.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 21:45, David Chow wrote:
> Non-technical Users:
> - Want the system to have drivers pre-built, so that they don't have to 
> go through a compilation or patching process. Its a waste of time for 
> them (waste of time for me too)
> - Why I have to search the drivers? Isn't is suppose to be included in 
> the OS? Or if not included in the OS, it should be included in a driver 
> disk (CD/DVD/floppy or whatever medium or download) .
> - Why I have to upgrade the complete OS if only one driver is missing? I 
> want to stay with Redhat-9 , my PHP runs great.

Then why MS has that auto-update service of theirs?

> - There is no "Linux support" labels on most the hardware out there, 
> should I risk my money, buy it and try out? Oh, full refund of item is 
> not allowed . Then, don't bother ...

Because hardware verdors act stupid and many of them still do
not write open-source drivers (or at least provide adequate docs).

> Commercial developers:
> - Want a stable API so that drivers can be maintained with ease. Because 
> we don't just work with Linux, we want to focus on our driver 
> development, not chasing the API changes, versions by versions, vendors 
> by vendors. Sometimes there are even vendor specific changes, its a 
> waste of time.
> - If I have to make binary drivers, I have to maintain all kernel 
> sources and headers, compilers to make sure my drivers will be built 
> correctly without problem. Of risk to change symbols in the binaries and 
> hope it works!

IOW: "we want to hijack millions of lines of Linux source and won't
contribute back our driver(s). Why do you kernel guys make that hard?"

Because we don't like what you're doing.

> - Where is the latest up-to-date documentation of the kernel API? 
> /Documentation only partially describe what I need, its version 
> specific, sometimes out-of-date, where the hell is that? Let's google it 
> in amazon.com, "Linux driver books", No good again.... Its crap, all not 
> up-to-date!

The source is ultimate doc. You never ever will get such a complete doc
for any commercial OS. It even documents all bugs! ;)

> - Lets get on to it, read all docs and sample sources... mmm... My 
> driver seems working now.. Lets compile it and distribute it. Users: 

Wrong. You should do: "Let's submit it for inclusion in mainline".
If you don't want to, it's your problem, not ours.

> have you got a driver for Redhat 9 2.4.18 kernel? Answer: No, it doesn't 
> work, because I write my driver on 2.6.15, you may to DIY. User 
> response: I want a refund, because you said your hardware has Linux 
> support, but its a false statement.
> - Just leave Linux, who cares, it doens't make sense to us. Because it 
> doesn't make sense to go through all these problems to say "Linux 
> supported hardware", user will get refund the product if we say this on 
> the box on day one.
> - Maybe we have another way to do that, submit the driver to the 
> community and hope it to include it in the latest kernel source. 
> Wait.... but what about support for Redhat 9 and SuSe 8.2?

You may backport your driver to older kernel(s). Sometimes distro(s)
will backport your driver to older kernels if there is demand.

> - We are happy to maintain our own drivers, because we know better about 
> our hardware. We are paid to do so, we also have quality assurance 
> process with formal test tools and equipment. Don't think the community 
> can do a better core than us.

Maintain them "in-tree", not in your own corner.

> - Wake up! Why would the maintainers bother to maintain the drivers if 
> the driver development work is now back to the hardware vendor, like 
> drivers for other platform did? I think someone mis-understood the whole 
> idea is to "GET RID OF DRIVER MAINTENANCE", belive it or not, it belongs 
> to the vendor, not here. If the driver releases as GPL, you can still 
> make your own changes, but it doesn't have to be in main source tree.

Yeah, yeah. I just wrestled with 2 so called "GDI" printers for Windows
from 2 different vendors. Both vendors _refused to fix obvious bugs_
in their Windows drivers. Do you want THIS type of driver maintenance
to occur in Linux world too?
--
vda
