Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVCAMNp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVCAMNp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 07:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbVCAMNp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 07:13:45 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:57997 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261886AbVCAMNl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 07:13:41 -0500
Message-Id: <200503010153.j211rGXB006246@laptop11.inf.utfsm.cl>
To: "David S. Miller" <davem@davemloft.net>
cc: linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
Subject: Re: SPARC64: Modular floppy? 
In-Reply-To: Message from "David S. Miller" <davem@davemloft.net> 
   of "Mon, 28 Feb 2005 15:51:42 -0800." <20050228155142.12ae31a7.davem@davemloft.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 28 Feb 2005 22:53:11 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b2 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 01 Mar 2005 09:13:08 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> said:
> On Mon, 28 Feb 2005 17:07:43 -0300
> Horst von Brand <vonbrand@inf.utfsm.cl> wrote:

[...]

> > So, either the dependencies have to get fixed so floppy can't be modular
> > for this architecture, or the relevant functions have to move from entry.S
> > to the module.

> I think the former is the best solution.  The assembler code really
> needs to get at floppy.c symbols.

>From my cursory look the stuff depending on the floppy.c symbols is just
in the floppy-related code. Can't that be just included in floppy.c?
(Could be quite a mess, but it looks like short stretches).
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

