Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264532AbTLLLhJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 06:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264535AbTLLLhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 06:37:09 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:10627 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S264532AbTLLLhG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 06:37:06 -0500
Date: Fri, 12 Dec 2003 11:36:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Craig Milo Rogers <rogers@isi.edu>
Cc: bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031212113650.GB12727@mail.shareable.org>
References: <3FCDE5CA.2543.3E4EE6AA@localhost> <3FCED34B.5050309@opersys.com> <1070669311.8421.35.camel@imladris.demon.co.uk> <3FD4C9C8.6040709@opersys.com> <br5b54$nbj$1@gatekeeper.tmr.com> <20031209214604.GA4542@isi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209214604.GA4542@isi.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Craig Milo Rogers wrote:
> On 03.12.09, bill davidsen wrote:
> > In article <3FD4C9C8.6040709@opersys.com>,
> > Karim Yaghmour  <karim@opersys.com> wrote:
> > | I didn't exactly specify how the interfacing would be done because that's
> > | besides the point I'm trying to make (in fact, it's the later part of my
> > | email which was most important). But here's two other ways to do it just
> > | for the sake of discussion:
> > | a) Hard-wired assembly in the driver that calls on the appropriate address
> > | with the proper structure offsets etc. No headers used here.
> > 
> > Well, the addresses and offset specs came from *somewhere*, and I would
> > love to hear someone argue that they "just seemed like good values," or
> > that reading the header file and then using absolute numbers isn't
> > derivative.

Using the absolute numbers and/or structures (i.e. the interface)
needed to progam a device seems like a fine example of fair use, even
when the header file containing them is copyrighted.

Fair use trumps derivation.

> 	INAL.  Observable facts (such as absolute numbers) aren't
> derivative (in the U.S.) because there's no "creativity"***.  See the
> famous court decision (... web search ...)  "Feist Publications
> v. Rural Telephone Serv. Co.", for example.  Of course, the DCMA (or
> other fell beasts) may have superseded that legal doctrine.

I guess a hardware manufacturer who feels their programming
information is worth keeping secret may well argue that they _chose_
the numbers that needed to be fed to their device, and thus they're creative.

But that's silly, and we're in deep shit if ever that argument is
taken seriously because _lots_ of Linux and BSD open source drivers
were developed by studying the behaviour or code of another driver.

-- Jamie

