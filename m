Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVA1DSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVA1DSf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 22:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVA1DSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 22:18:35 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:53395 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261424AbVA1DSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 22:18:34 -0500
Message-Id: <200501280203.j0S23Fc8008333@laptop11.inf.utfsm.cl>
To: Julien TINNES <julien.tinnes@francetelecom.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch 4/6 randomize the stack pointer 
In-Reply-To: Message from Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com> 
   of "Thu, 27 Jan 2005 20:43:30 BST." <41F94462.7080108@francetelecom.REMOVE.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Thu, 27 Jan 2005 23:03:15 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien TINNES <julien.tinnes.NOSPAM@francetelecom.REMOVE.com> said:
> Not very important but ((get_random_int() % 4096) << 4) could be 
> optimized into get_random_int() & 0xFFF0.

Check first if the compiler doesn't do it by itself.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
