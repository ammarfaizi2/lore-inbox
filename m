Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264637AbUEaNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264637AbUEaNoP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUEaNlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:41:07 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:13800 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S264638AbUEaNja (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:39:30 -0400
Message-Id: <200405311339.i4VDdCba002939@eeyore.valparaiso.cl>
To: Ian Kent <raven@themaw.net>
cc: ndiamond@despammed.com, linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module? 
In-Reply-To: Message from Ian Kent <raven@themaw.net> 
   of "Mon, 31 May 2004 13:44:40 +0800." <Pine.LNX.4.58.0405311340450.4198@wombat.indigo.net.au> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Mon, 31 May 2004 09:39:12 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kent <raven@themaw.net> said:

[...]

> Why not scaled longs (or bigger), scalled to number of significant 
> digits. The Taylor series for the trig functions might be a painfull.

Trascendental functions are _not_ computed by series in practice, rational
approximations (polinomial / polinomial) are used instead. Or interpolate
in a smallish table.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
