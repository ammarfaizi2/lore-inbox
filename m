Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVC1Uw2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVC1Uw2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbVC1Uue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:50:34 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57811 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262060AbVC1UuD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:50:03 -0500
Message-Id: <200503282047.j2SKlRCc029479@laptop11.inf.utfsm.cl>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Aaron Gyes <floam@sh.nu>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!. 
In-Reply-To: Message from Steven Rostedt <rostedt@goodmis.org> 
   of "Mon, 28 Mar 2005 07:04:01 EST." <1112011441.27381.31.camel@localhost.localdomain> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 28 Mar 2005 16:47:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 28 Mar 2005 16:47:32 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> said:
> On Sun, 2005-03-27 at 21:54 -0400, Horst von Brand wrote:

[...]

> > Wrong. You are free to do whatever you like in the privacy of your home,
> > but not distribute the result. So you could very well distribute both
> > pieces, one under GPL, the other not, and leave the linking to the end
> > user.
> > 
> > Sure, /creating/ the piece to be linked with the GPLed code might make it
> > GPL also, but that is another story.

> Actually this is an easy one. If you are the creator of the code, you
> can license it anyway you want. So you can make it both GPL and allow it
> to link with your code. Heck, put it under LGPL since GPL is allowed to
> link to that.

Right, but that is not the point. If you need to look closely at the GPL
part, or swipe stuff from other GPLed code that uses the same interface,
the result might have to be GPL.

> Anyway, I don't think that the GPL is that powerful to affect things not
> linked directly with it. Just like the MS license can't make you do
> certain things that were stated in the license, the GPL can't take too
> much control over what you do.  If something in the license is
> reasonable, than it is easy to enforce (like taking the code from GPL
> source and using it in a binary) but if it starts to stretch (like
> controlling the code you write and how you can use it) then that will
> have to be fought in court, and will probably lose.

The problem is that noone is sure what exactly qualifies as "derived work",
and what can be used/copied without concern for infringement (Can you use
declarations of stuff in a public .h? What if the .h is "local use" in the
code? Can you write your own declarations matching what you find in random
code, and use them? What about inlined functions?  Lists of e.g. IOCTL
codes or system calls?). Does it matter that you are writing your stuff for
compatibility with what is out there, or to add functionality? Does it
matter if you are just using "standard" interfases to the GPLed stuff
(whatever that means in each case)? How much copying makes it derived? 1
line, 5%, what?
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
