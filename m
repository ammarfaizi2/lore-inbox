Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUFHM1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUFHM1m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 08:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbUFHM1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 08:27:42 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:43216 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265109AbUFHM1l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 08:27:41 -0400
Message-Id: <200406080245.i582jSSp022846@eeyore.valparaiso.cl>
To: Hal Nine <hal9@cyberspace.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Flushing the swap 
In-Reply-To: Message from Hal Nine <hal9@cyberspace.org> 
   of "Mon, 07 Jun 2004 18:34:59 -0400." <200406072234.SAA07853@grex.cyberspace.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 07 Jun 2004 22:45:27 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hal Nine <hal9@cyberspace.org> said:
> Is there any way of making linux flush out all pages out of swap
> space?  I want to have 0K of used swap space.

What for? If they don't fit into RAM (likely, as swap is essentially "RAM
overflow"), you are toast anyway.

You might try swapoff(8)...
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
