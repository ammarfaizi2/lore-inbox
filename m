Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbUB2McJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 07:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbUB2McJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 07:32:09 -0500
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:16590 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S262041AbUB2McF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 07:32:05 -0500
To: Grigor Gatchev <grigor@zadnik.org>
Cc: Christer Weinigel <christer@weinigel.se>, <linux-kernel@vger.kernel.org>
Subject: Re: A Layered Kernel: Proposal
References: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 29 Feb 2004 13:32:04 +0100
In-Reply-To: <Pine.LNX.4.44.0402252133300.18217-100000@lugburz.zadnik.org>
Message-ID: <m365dqoym3.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grigor Gatchev <grigor@zadnik.org> writes:

> > In the linux kernel I think that one of the most important things I've
> > learned from it: middle layers are usually wrong.  Instead of hiding a
> > device driver behind a middle layer, expose the low level device
> > driver, but give it a library of common functions to build upon.  That
> > way the driver is in control all the time and can use all the neat
> > features of the hardware if it wants to, but for all the common tasks
> > that have to be done, hand them over to the library.
> 
> By principle, the "least common denominator" type container layers are
> bad, because of not being extendable; you are completely right here. A
> class-like driver object model seems better to me. And the class-like
> model is not the only one that is nicely extendable. 

> You seem to be knowledgeable on the topic - what driver object model
> would you suggest for a driver layer model?

Thanks for the confidence, bur I really don't know, it's much easier
to criticize someone elses design than to come up with a good one
myself. :-)

With that said, I think that they way the Linux kernel is moving
regarding to IDE/SCSI devices is a good idea.  Linux has been around
for a while now and the Linux people have tried lots of things that
turned out not to be such a good idea after all.  Many things are
still there in the kernel, but if it's important enough, it gets
cleaned up after a while.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
