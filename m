Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751622AbWCIJVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWCIJVk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 04:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWCIJVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 04:21:40 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:6822 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751493AbWCIJVk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 04:21:40 -0500
Message-ID: <440FF39A.7010207@aitel.hist.no>
Date: Thu, 09 Mar 2006 10:21:30 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anshuman Gholap <anshu.pg@gmail.com>
CC: linux-kernel@vger.kernel.org, Jan Knutar <jk-lkml@sci.fi>
Subject: Re: [future of drivers?] a proposal for binary drivers.
References: <ec92bc30603080135j5257c992k2452f64752d38abd@mail.gmail.com>	 <200603081151.33349.jk-lkml@sci.fi> <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
In-Reply-To: <ec92bc30603080203rb4f5e7bvea993a44ceb5d3ca@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anshuman Gholap wrote:

>Hello Jan,
>
>you said  quote, "The real question is: Why do binary-only drivers
>need to exist?"
>
>super super super nice question.
>
>ok here is the deal, My bro who is a doctor and has lenovo laptop,
>buys lets say dlink pcmcia wifi card , and opens the box, gets the
>hardware out and the software  cd out, all he sees is windows related
>drivers and documentation, he and any person like him wont even bother
>how to plug this in ubuntu linux (which i almost mind-controlled him
>into installing it) , he knowing me as a linux person will keep
>bugging me, when i tell him to install a kernel source compile it to
>allow 16k stack, install ndiswrapper and load the windows driver and
>compile install gtk-wifi app and get wifi network.  he might admit me
>into hospital for talk_while_geek with a normal person.
>
>if there was binary allowed (with any license) maybe dlink themself
>would build a driver, make documentation and provide it on CD, just
>see how much effort would be saved and in end he would get more time
>to treat his patients.
>  
>
This is where your assumption is _WRONG_. 

Sure - it would be nice if dlink provided a driver!

But there is _no need_ for this driver to be binary!

You see, providing a open-source driver is no harder than
a binary one for the provider.  This because _all_ drivers have
source.  If the open driver is for somewhat popular hardware then
the company won't even have to maintain it - someone will
usually do it.  So usually, a company can save money by
providing source.

Second, an open source driver will make life much much easier
for the end-users too.  Much easier, in fact, than a binary driver
provided on a cd.  Why?  Because you actually have to install
binary drivers.  That's work an end-user don't want to do.

An open-source driver however, will be integrated into the
linux kernel source.  That means that when you install linux
(or have someone else install it, as "computer dummies" do,)
then the driver is in the machine already. 

When a linux distribution is on your machine, then all the
open source drivers supported by linux is there already.
You can add hardware, and it will work either immediately
(USB, cardbus, other hotplug stuff) or after the next boot
(PCI, IDE, other non-hotplug stuff.)

Of course, you have to take care to buy hardware that
linux actually support.  Not a big problem, for linux
support all categories of hardware even if there certainly
is unsupported hardware too.

This is no different from the windows world - you don't
want to buy unsupported hardware there either.
And yes, such hardware exist. The obvious example
is any computer with an intel-incompatible processor,
many of which runs linux just fine. :-)

>I have thousands of similar scenarios. Even I wont mind the luxury of
>making hardware just working and not going to google>>download src>>if
>bug/error found>>go to forums post thread>>hang on irc and bug
>ppl>>get more things compiled done >>if work then enjoy>> or wait for
>the philanthropic coder to solve bug and release new ver.
>  
>
Linux surely have the luxury of hardware that just works.
Poor windows users - they actually need to mess around
with the driver CDs that comes with most hardware. I don't!
And when they reinstall, they need all those CDs again. I don't.
And if they stumble onto a bug - and yes, they do sometimes,
then they can write to microsoft and only hope to
get any answer at all. When was the last time microsoft (or
someone providing windows drivers for their hardware)
fixed a bug and released an update a few _hours_ after
a bug report?  With linux, that happens all the time,
although there sure are bugs that take longer too.


To put it short - the problem you describes is easily
solved by drivers.  There is no reason whatsoever
for them to be binary though.  (As an end-user, your
brother won't need the compiler, he'll get the driver
precompiled from his linux distribution vendor - _if_
they have access to an open source driver.)

Helge Hafting
