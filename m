Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbVJFDmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbVJFDmG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 23:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJFDmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 23:42:06 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45727 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751207AbVJFDmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 23:42:05 -0400
Message-Id: <200510060256.j962uXvl008891@inti.inf.utfsm.cl>
To: Marc Perkel <marc@perkel.com>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Florin Malita <fmalita@gmail.com>, nix@esperi.org.uk, 7eggert@gmx.de,
       lkcl@lkcl.net, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel? 
In-Reply-To: Message from Marc Perkel <marc@perkel.com> 
   of "Wed, 05 Oct 2005 13:05:30 MST." <4344320A.7090007@perkel.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Wed, 05 Oct 2005 22:56:33 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel <marc@perkel.com> wrote:

[...]

> What you don't understand is that Netware's permissions mechanish is
> totally different that Linux. A hard link in Netware wouldn't inherit
> rights the way Linux does. So the user would have rights to their hard
> link to delete that link without having rights to unlink the file.

OK, so a "hard link" isn't (because it has separate permissions than the
original). Sorry, watered-down symlinks don't cut it. Or just by linking
the file into my place I now have rights to modify it? The later idea makes
my skin try to crawl away...

> This is an important concept so pay attention. Linux stores all the
> permission to a file with that file entry.

You are completely right: This is an extremely central concept to
everything Unix.

>                                            Netware doesn't. Netware
> calculates effective rights from the parent directories and it is all
> inherited unless files or directoies are explicitly set
> differently. So if files are added to other people folders then those
> people get rights to it automatically without having to go to the
> second step of changing the file's permissions.

Which is a very clear explanation of how broken it all is. No wonder
NetWare is no more. Files whose persmissions change depending on which way
you look at them is a nightmare. Sure, you /can/ manage that for small(ish)
setups by brute force, but it soon has to break down.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
