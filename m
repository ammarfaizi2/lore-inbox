Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750768AbVLBPY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVLBPY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750786AbVLBPY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 10:24:58 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:31390 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id S1750768AbVLBPY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 10:24:57 -0500
Message-Id: <200512021421.jB2ELkJw013434@pincoya.inf.utfsm.cl>
To: Coywolf Qi Hunt <coywolf@gmail.com>
cc: Peter Williams <pwil3058@bigpond.net.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, sam@ravnborg.org
Subject: Re: [q] make modules_install as non-root? 
In-Reply-To: Message from Coywolf Qi Hunt <coywolf@gmail.com> 
   of "Fri, 02 Dec 2005 10:59:11 +0800." <2cd57c900512011859v7f0db82fg@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Fri, 02 Dec 2005 11:21:46 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@gmail.com> wrote:
> 2005/12/2, Peter Williams <pwil3058@bigpond.net.au>:

[...]

> > Personally, I just use "sudo make install" or "sudo make
> > modules_install" to do installations as an ordinary user.  No need for
> > special scripts or modifications to the build procedure.

> That's rather insecure. You have to add /usr/bin/make in your sudoers,
> then an malicious Makefile could do harm. I'm being paranoid. But we
> all are since we avoid to use root.

Oh, come on. If somebody can mess with your kernel sources, you are toast
anyway. No need to doctor a Makefile for that at all.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
