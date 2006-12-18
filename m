Return-Path: <linux-kernel-owner+w=401wt.eu-S1754573AbWLRUuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbWLRUuU (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 15:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbWLRUuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 15:50:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44856 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573AbWLRUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 15:50:19 -0500
Date: Mon, 18 Dec 2006 12:50:09 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Ricardo Galli <gallir@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules
In-Reply-To: <or64c96ius.fsf@redhat.com>
Message-ID: <Pine.LNX.4.64.0612181242530.3479@woody.osdl.org>
References: <200612161927.13860.gallir@gmail.com> <Pine.LNX.4.64.0612161253390.3479@woody.osdl.org>
 <orwt4qaara.fsf@redhat.com> <Pine.LNX.4.64.0612170927110.3479@woody.osdl.org>
 <orpsah6m3s.fsf@redhat.com> <Pine.LNX.4.64.0612181134260.3479@woody.osdl.org>
 <or64c96ius.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Alexandre Oliva wrote:
>
> > In other words, in the GPL, "Program" does NOT mean "binary". Never has.
> 
> Agreed.  So what?  How does this relate with the point above?
> 
> The binary is a Program, as much as the sources are a Program.  Both
> forms are subject to copyright law and to the license, in spite of
> http://www.fsfla.org/?q=en/node/128#1

Here's how it relates:
 - if a program is not a "derived work" of the C library, then it's not 
   "the program" as defined by the GPLv2 AT ALL.

In other words, it doesn't matter ONE WHIT whether you use "ld --static" 
or "ld" or "mkisofs" - if the program isn't (by copyright law) derived 
from glibc, then EVEN IF glibc was under the GPLv2, it would IN NO WAY 
AFFECT THE RESULTING BINARY.

And I'm simply claiming that a binary doesn't become "derived from" by any 
action of linking.

Even if you link using "ld", even if it's static, the binary is not 
"derived from". It's an aggregate.

"Derivation" has nothing to do with "linking". Either it's derived or it 
is not, and "linking" simply doesn't matter. It doesn't matter whether 
it's static or dynamic. That's a detail that simply doesn't have anythign 
at all to do with "derivative work".

THAT is my point. 

Static vs dynamic matters for whether it's an AGGREGATE work. Clearly, 
static linking aggregates the library with the other program in the same 
binary. There's no question about that. And that _does_ have meaning from 
a copyright law angle, since if you don't have permission to ship 
aggregate works under the license, then you can't ship said binary. It's 
just a non-issue in the specific case of the GPLv2.

In the presense of dynamic linking the binary isn't even an aggregate 
work.

THAT is the difference between static and dynamic. A simple command line 
flag to the linker shouldn't really reasonably be considered to change 
"derivation" status.

Either something is derived, or it's not. If it's derived, "ld", 
"mkisofs", "putting them close together" or "shipping them on totally 
separate CD's" doesn't matter. It's still derived.

		Linus
