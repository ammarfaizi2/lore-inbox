Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266226AbUFUNJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266226AbUFUNJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 09:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266219AbUFUNGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 09:06:52 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5091 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S266221AbUFUNDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 09:03:07 -0400
Message-Id: <200406200219.i5K2JbiY005449@eeyore.valparaiso.cl>
To: matthew-lkml@newtoncomputing.co.uk
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars 
In-Reply-To: Message from matthew-lkml@newtoncomputing.co.uk 
   of "Sat, 19 Jun 2004 16:49:07 +0100." <20040619154907.GE5286@newtoncomputing.co.uk> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 19 Jun 2004 22:19:37 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

matthew-lkml@newtoncomputing.co.uk said:
> On Sat, Jun 19, 2004 at 12:18:24PM +0100, David Woodhouse wrote:

[...]

> > Please don't do that -- it makes printing UTF-8 impossible. While I'd
> > not argue that now is the time to start outputting UTF-8 all over the
> > place, I wouldn't accept that it's a good time to _prevent_ it either,
> > as your patch would do.

> Please forgive me if I'm wrong on this, but I seem to remember reading
> something a while ago indicating that the kernel is and always will be
> internally English (i.e. debugging messages and the like) as there is no
> need to bloat it with many different languages (that can be done in
> userspace). As printk is really just a log system, I personally don't
> see any way that it should ever print anything other than ASCII.

Messages including user-level stuff (file names, ...) could very well be
UTF-8.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
