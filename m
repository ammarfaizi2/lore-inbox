Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268567AbTGLWR0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 18:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268577AbTGLWR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 18:17:26 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:26756 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S268567AbTGLWRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 18:17:24 -0400
Message-Id: <200307121840.h6CIeKIj004212@eeyore.valparaiso.cl>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Style question: Should one check for NULL pointers? 
In-Reply-To: Your message of "Fri, 11 Jul 2003 11:16:02 -0400."
             <Pine.LNX.4.44L0.0307111108500.21359-100000@netrider.rowland.org> 
X-Mailer: MH-E 7.1; nmh 1.0.4; XEmacs 21.4
Date: Sat, 12 Jul 2003 14:40:20 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> said:

[...]

> But if you look very far through the kernel sources you will see many 
> occurrences of code similar to this:
> 
> 	static void release(struct xxx *ptr)
> 	{
> 		if (!ptr)
> 			return;
> 	...
> 
> I can't see any reason for keeping something like that.

Just like free(3)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
