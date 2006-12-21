Return-Path: <linux-kernel-owner+w=401wt.eu-S1422965AbWLUQnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422965AbWLUQnR (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422969AbWLUQnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:43:17 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34497 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422965AbWLUQnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:43:16 -0500
Message-Id: <200612211643.kBLGh6cE028211@laptop13.inf.utfsm.cl>
To: Marek Wawrzyczny <marekw1977@yahoo.com.au>
cc: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19] 
In-Reply-To: Message from Marek Wawrzyczny <marekw1977@yahoo.com.au> 
   of "Fri, 22 Dec 2006 02:34:54 +1100." <200612220234.55313.marekw1977@yahoo.com.au> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Thu, 21 Dec 2006 13:43:06 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 21 Dec 2006 13:43:06 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marek Wawrzyczny <marekw1977@yahoo.com.au> wrote:

[...]

> No, no, no...  I was never proposing that. I was thinking of something more 
> along the lines of reporting back on open-source friendliness of 
> manufacturers of devices, and perhaps on the availability of open source 
> drivers for the devices. I am talking only about "detected" devices. The 
> database would never try and guess the vendor, model and variation of the 
> system.

This is a /massive/ ammount of effort, and the data required is hard to
come by before buying, so it is rather useless. What chip is in NetworkCard
675? In 675a? (yes, I've seen dLink cards called <foo> and <foo>+ which
were /radically/ different!). Yes, here you go to the computer store and
ask them to build you a machine from parts you specify. But it is far from
the common way to get a PC (those stores mostly cater to heavy-weight
gamers, many pieces have to be special ordered), and building a machine
that works OK with Linux is a two or three day exercise in hunting down
specifications for compatible pieces. Most folks wander into the next
department store and buy a PC. Mostly terrible crap, BTW.

Where this makes sense (printers!) the data is there, mostly up to date,
and accurate.

[...]

> I actually find that trying to obtain information about what hardware
> is/isn't supported in Linux is actually quite difficult to obtain. The
> information that's on the internet is either outdated or has not yet been
> written.  I was hoping to analyze the system's device information
> together with driver/device information obtained from the kernel source
> itself to give users a better (but not perhaps not as authoritative as
> I'd like to) picture of what to expect.

There is just way too much hardware out there, and new pieces come out
every day. Then there are lots of integrators that buy chips and build PCI
cards. Sometimes cards with supported chips just don't work at all. Etc. It
is all over the map.

Besides, many times you don't find information on some piece of hardware it
is because it is dirt cheap stuff that has no chance of working, so nobody
even tried.

[...]

> > Bonus points for figuring out what to do with systems that have some chip
> > that's a supported XYZ driver, but wired up behind a squirrely bridge with
> > some totally bizarre IRQ allocation, so you end up with something that's
> > visible on lspci but not actually *usable* in any real sense of the term...

> Hmmm... does this happen often? False results are definedly a show
> stopper.

Not just for systems, even for individual cards.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
