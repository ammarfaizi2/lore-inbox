Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbTIOXPi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbTIOXOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:14:54 -0400
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:20418 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S261673AbTIOXOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:14:33 -0400
From: James Clark <jimwclark@ntlworld.com>
Reply-To: jimwclark@ntlworld.com
To: linux-kernel@vger.kernel.org
Subject: Re: Discourage Uniform Driver Model
Date: Tue, 16 Sep 2003 00:13:38 +0100
User-Agent: KMail/1.5
References: <200309140027.08610.jimwclark@ntlworld.com> <200309142138.32222.jimwclark@ntlworld.com> <1063577498.2472.3.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1063577498.2472.3.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309160013.38466.jimwclark@ntlworld.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How does your proposal differ/improve on the demand-load module system?

Modules must be (re)compiled for each specific kernel release. This is because 
of the very tight coupling with the kernel. The kernel changes so much that 
it is often necessary to amend a module to keep up. My suggestion is to 
create an abstract interface between the two. The interface (called a binary 
interface) would define the way the two 'talk' to one another. Once the 
interface has been released as v1.0 any module could be made compatible with 
the v1.0 interface. After a while it would be necessary to release improved 
interfaces. This would not break the existing modules as the old interface 
could remain due to its abstract nature. This technique is used in everything 
from Windows drivers, Netscape pluggins and even normal programs - image 
saying you must buy a new version of Word Perfect for every minor release of 
the OS - it has 'binary' compatibility. Unfortunately many see this as active 
encouragement of 'binary only' modules which have no source code. This idea 
would cost in performance. I suggest this loss is worthwhile to resolve 
compatibility and usability.

>   This seemed to work well in Mandrake, or am I missing the point?!?

Unless you build the module yourself you are the mercy of Mandrake to make 
each module - I don't see this as being much different from the situation 
with Windows.  Poor old Mandrake must remake almost every module almost 
everytime. You cannot use a module from Redhat's kernel. In effect everyone 
is duplicating effort. Modules must currently be compiled, this requires a 
degree of expertise and can be daunting to someone who just wants to use the 
OS. My suggestion would not remove need to release modules in source form, 
but once compiled they could be plugged into any kernel and distributed in 
binary+source form. 

> Also, the only reply to your posting that I read (and I've only read a
> fraction of them!) which offered any genuine usefulness was the point
> that if you offer the code then they'll consider the merits.  Are you
> considering an actual solution, or just suggesting a policy change?

I understand the way competitor binary interfaces work. Currently I'm not 
going to roll up my sleeves and write this system. I don't have the technical 
expertise to design such a thing and although I could learn the curve at this 
time is too steep. I do think that my experience with similar competitor 
systems allows me to speak on the subject. However, I feel that pushing for 
this change is a positive thing. It has started a debate on 'misusing' the 
GPL to prevent binary only modules and has resulted in some positive 
comments. If they debate it  rationally and then decide not to bother I will 
have achieved a lot. I do  feel qualified to make this (obvious) suggestion 
and comment on the design of any resulting interface.

James

