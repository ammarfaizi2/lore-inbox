Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263147AbUEWQT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbUEWQT2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 12:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbUEWQT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 12:19:28 -0400
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:56192 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S263147AbUEWQT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 12:19:27 -0400
Message-Id: <200405231619.i4NGJBe18903@pincoya.inf.utfsm.cl>
To: Linus Torvalds <torvalds@osdl.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, vonbrand@inf.utfsm.cl
Subject: Re: Linux 2.6.7-rc1 
In-reply-to: Your message of "Sat, 22 May 2004 23:38:45 MST."
             <Pine.LNX.4.58.0405222331200.18534@ppc970.osdl.org> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Sun, 23 May 2004 12:19:11 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> said:
> Hmm.. This is stuff all over the map, but most interesting (or at least
> most "core") is probably the merging of the NUMA scheduler and the anonvma
> rmap code. The latter gets rid of the expensive pte chains, and instead
> allows reverse page mapping by keeping track of which vma (and offset)  
> each page is associated with. Special kudos to Andrea Arcangeli and Hugh
> Dickins.
> 
> 		Linus

Not wanting to start a flamewar, but this sort of massive changes in a
_stable_ series has got me quite confused... either 2.6.0 was premature, or
the "just stabilize 2.6, new stuff only into 2.7 (when it opens)" got lost
somewhere.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
