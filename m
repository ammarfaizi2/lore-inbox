Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261878AbVASUiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261878AbVASUiF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 15:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVASUiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 15:38:05 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47765 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261878AbVASUiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 15:38:01 -0500
Message-Id: <200501192037.j0JKbpuA008501@laptop11.inf.utfsm.cl>
To: Carl Spalletta <cspalletta@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux-tracecalls, a new tool for Kernel development, released 
In-Reply-To: Message from Carl Spalletta <cspalletta@yahoo.com> 
   of "Wed, 19 Jan 2005 11:38:32 -0800." <20050119193832.34975.qmail@web53803.mail.yahoo.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 19 Jan 2005 17:37:51 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.4 (inti.inf.utfsm.cl [200.1.19.1]); Wed, 19 Jan 2005 17:37:55 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl Spalletta <cspalletta@yahoo.com> said:
> >From http://www.linuxrd.com/~carl/cgi-bin/lnxtc.pl?help

[...]

> "It works, in part, by expanding function-yielding macros and by mangling
> function names with the name of the file containing the function's
> definition, prior to creating the cscope files."

If it can't find out where a function could be called through a pointer
(very common due to the OOP-in-C style in the kernel) it has no chance.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
