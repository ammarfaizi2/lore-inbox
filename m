Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964855AbVITD23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964855AbVITD23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 23:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964856AbVITD23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 23:28:29 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:14037 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964855AbVITD23 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 23:28:29 -0400
Message-Id: <200509192349.j8JNnAbW031924@inti.inf.utfsm.cl>
To: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
cc: Pavel Machek <pavel@ucw.cz>, Martin Mares <mj@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts 
In-Reply-To: Message from =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de> 
   of "Mon, 19 Sep 2005 09:18:33 +0200." <432E6649.1070408@v.loewis.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 19 Sep 2005 19:49:10 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin v. Löwis <martin@v.loewis.de> wrote:
> Pavel Machek wrote:
> > Why is binfmt_misc not enough for you?

> For two reasons: for one, it has the overhead of yet another
> exec call.

For an interpreted language this is surely irrelevant.

[...]

> The other reason is availability: as an author of an UTF-8
> script, you would have to communicate to your users that they
> need the right binfmt_misc wrapper installed (which they may
> have to build first). While installing additional stuff to
> run a single program is acceptable for large applications,
> it is likely not for script files. To make the feature useful
> in practice, it must be builtin.

That is a distribution problem.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
