Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262467AbVAEPNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262467AbVAEPNP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 10:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVAEPNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 10:13:13 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:51647 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S262467AbVAEPLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 10:11:34 -0500
Message-Id: <200501051511.j05FB0wi008950@laptop11.inf.utfsm.cl>
To: krishna <krishna.c@globaledgesoft.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Con Kolivas <lkml@kolivas.org>
Subject: Re: How to write elegant C coding 
In-Reply-To: Message from krishna <krishna.c@globaledgesoft.com> 
   of "Wed, 05 Jan 2005 09:13:04 +0530." <41DB6248.2030003@globaledgesoft.com> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 15)
Date: Wed, 05 Jan 2005 12:11:00 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

krishna <krishna.c@globaledgesoft.com> said:

[...]

> What I mean is both elegant and _efficient_ best practices in C coding.

Look for "Writing Efficient Programs", by Jon Bentley (sadly out of print),
and his "Programming Pearls" (2nd edition).

Keep in mind that "efficient" is mostly a thing of overall organization and
careful design (and data structure definition), not detailed programming.
Microoptimizations are usually counter-productive, at least by making the
code unnecessarily hard to read; current compilers aim at generating code
from "normally written C" that is at least as good as that a competent
assembly programmer would write with care (and often writing "more
efficient source code" just confuses the compiler into giving worse
results). Better aim at understandable, easy to get right code. If you
_measure_ later that it is too slow/large/..., _then_ go back and see how
to make it better. So Documentation/CodingStyle is an excellent starting
point.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
