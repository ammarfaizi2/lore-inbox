Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262374AbVGGAX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262374AbVGGAX3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262126AbVGFUDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:03:35 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41102 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262354AbVGFRgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 13:36:21 -0400
Message-Id: <200507061730.j66HUZ8R015013@laptop11.inf.utfsm.cl>
To: Hans Reiser <reiser@namesys.com>
cc: Martin Waitz <tali@admingilde.org>, Jonathan Briggs <jbriggs@esoft.com>,
       Ross Biro <ross.biro@gmail.com>, Hubert Chan <hubert@uhoreg.ca>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, David Masover <ninja@slaphack.com>,
       Valdis.Kletnieks@vt.edu, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins 
In-Reply-To: Message from Hans Reiser <reiser@namesys.com> 
   of "Wed, 06 Jul 2005 02:02:16 MST." <42CB9E18.8080206@namesys.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 06 Jul 2005 13:30:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 06 Jul 2005 13:30:39 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:

[...]

> I think the exokernel approach by Frans is a very interesting approach. 
> I wish I had the experience with it necessary to know if it was
> effective.  I do NOT take the position that name resolution should be in
> the kernel.  I DO take the position that it should be either in the
> kernel or out of the kernel, and should constitute one cohesive and
> coherent body of code.

Right.

>                         If someone talks Linus into trying the exokernel
> approach,

Are you nuts?! Such radical experiments do /not/ belong in the kernel on
which millions of machines depend!

Go and fork off a branch to play around with this, and if it does show real
promise, you can then come back and try to integrate this into the official
kernel.

>           I will be happy to educate myself to where I have an opinion
> on whether that works.  It is easy to see powerful advantages to the
> exokernel approach: I wish I understood the security model for it, and I
> wish I was sure that name resolution would not require too many context
> switches as one fetches each storage component required by a name
> resolution.

Exactly the kinds of questions that have to get solid answers before any
experimental patches can get off the ground.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
