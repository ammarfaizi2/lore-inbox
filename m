Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUE3CgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUE3CgZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 22:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUE3CgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 22:36:25 -0400
Received: from paynac.inf.utfsm.cl ([200.1.19.204]:19607 "EHLO
	paynac.inf.utfsm.cl") by vger.kernel.org with ESMTP id S261605AbUE3CgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 22:36:24 -0400
Message-Id: <200405292105.i4TL5mdT004928@pincoya.inf.utfsm.cl>
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org 
In-Reply-To: Message from Jan-Benedict Glaw <jbglaw@lug-owl.de> 
   of "Fri, 28 May 2004 10:55:23 +0200." <20040528085523.GP1912@lug-owl.de> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Sat, 29 May 2004 17:05:48 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw <jbglaw@lug-owl.de> said:

[...]

> Disagree! Mirroring with ftp is possibly quite a waste of bandwidth (at
> least in case partial file transfers etc.),

mirror is smarter than that...

>                                             and IIRC you can't reliably
> mirror symlinks (IIRC the "ls"/"dir" output is only ment to be
> human-readable), hardlinks and the like.

So? A script that is smart enough can figure them out too...

> If you see aborts [with rsync], properly set the timeout parameter...

With mirror you can use file patterns to include/exclude (e.g. get just the
.bz2 versions (not redundant .gz)), only consider "new" files (i.e.,
exclude anything more than a week old), etc.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
