Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265065AbUEYT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265065AbUEYT25 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265068AbUEYT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:28:56 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:27520 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S265065AbUEYT2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:28:45 -0400
Message-Id: <200405251928.i4PJSJr25717@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       vonbrand@inf.utfsm.cl
Subject: Re: [RFD] Explicitly documenting patch submission 
In-reply-to: Your message of "Mon, 24 May 2004 20:50:28 MST."
             <Pine.LNX.4.58.0405242044260.32189@ppc970.osdl.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 25 May 2004 15:28:18 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:

[...]

> One reason for uniqueness is literally for automatic parsing - having 
> scripts that pick up on this, and send ACK messages, or do statistics on 
> who patches tend to go through etc etc. 

AFAIU, what you really want is to go back 20 years from now and say "See? 
Lines 257-300 of foo/bar.c were contributed originally by J. Random Hacker
(here his signoff), and then modified by Jane Random and George Hacker, and
Aunt Tillie's grandson looked it over and blessed it into the official
kernel (signoffs here). If you got a problem with that, go talk to them." 
(that is what SCOundrels would need in place to be discouraged, I'm
afraid...).

Problem with your proposal for this is that either you keep patches from
the source intact (i.e., a bunch of one-liners each signed off separately,
signed off each one by the maintainer, plus a patch by said maintainer to
beat it all into useable shape) or shift the burden of being able to say
later (even _much_ later) that the patch was the bundling and mangling of
the individual patches.

I.e., this is an idea which was perhaps more appropiate in the olden days
when there was no maintainer hierarchy in place yet...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
