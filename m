Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTLKIhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 03:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTLKIhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 03:37:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:15489
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264528AbTLKIh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 03:37:27 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: <hzhong@cisco.com>, "'Larry McVoy'" <lm@bitmover.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 11 Dec 2003 02:37:42 -0600
User-Agent: KMail/1.5
Cc: "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
References: <014301c3bfbe$67fa1540$d43147ab@amer.cisco.com>
In-Reply-To: <014301c3bfbe$67fa1540$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312110237.42998.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 December 2003 02:11, Hua Zhong wrote:
> > For one thing, the plugin was made by someone without access
> > to Netscape or IE's source code, using a documented interface
> > that contained sufficient information to do the job without access
> > to that source code.
> >
> > Yes, it matters.
>
> _What_ matters?
>
> Open source? (if you write a plugin for an opensource
> kernel/application, you are not plugin anymore and you are derived
> work.) I am sure you don't mean it.
>
> Documented interface? Hey, there are sources which are the best
> documentation. :-)

If you write software by referring to documentation, the barrier for it being 
a derivative work is higher than if you write it by looking at another 
implementation.

> Seriously, even if I accept that there is never an intent to support a
> stable ABI for kernel modules, some vendor can easily claim that "we
> support a stable ABI, so write kernel modules for the kernel we
> distribute".
>
> Anything can prevent that? I cannot see GPL disallow it.
>
> So OK, Linus and other kernel developers never intended to provide a
> stable ABI, but someone else could. The original author's intent is
> never relevant anymore. This is the goodness of opensource, isn't it?

Once upon a time, Compaq did a clean-room clone of IBM's BIOS.  Group 1 
studied the original bios and wrote up a spec, and group 2 wrote a new bios 
from that spec, and group 1 never spoke to group 2, and all of this was 
extensively documented so that when IBM sued them they proved in court that 
their BIOS wasn't derived from IBM's.  (Of course compaq used vigin 
programmers fresh out of college who'd never seen a PC before, which was a 
lot easier to do in 1983...)

I didn't make this up.  This was a really big deal 20 years ago.  It happened, 
and it mattered, and people cared that they created a fresh implementation 
without seeing the original code, entirely from a written specification that 
was not a derivative work of the first implementation, so no matter how 
similar the second implementation was (hand-coded assembly performing the 
same functions on the same processor in the same amount of space), it could 
not be considered a derivative work.

This was a strong enough defense to beat IBM's lawyers, who were trying to 
claim that Compaq's new BIOS WAS a derivative work...

Rob
