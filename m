Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbVDVFdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbVDVFdl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 01:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbVDVFdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 01:33:25 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:15796 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261985AbVDVFdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 01:33:14 -0400
Message-Id: <200504220337.j3M3biAb004521@laptop11.inf.utfsm.cl>
To: Petr Baudis <pasky@ucw.cz>
cc: tony.luck@intel.com, Linus Torvalds <torvalds@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull 
In-Reply-To: Message from Petr Baudis <pasky@ucw.cz> 
   of "Fri, 22 Apr 2005 00:53:24 +0200." <20050421225324.GA1474@pasky.ji.cz> 
Date: Thu, 21 Apr 2005 23:37:44 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis <pasky@ucw.cz> said:

[...]

> The way to work around that is to setup separate rsync URIs for each of
> the trees. ;-) I think I will make git-pasky (Cogito) accept also URIs
> in form
> 
> 	rsync://host/path!branchname
> 
> which will allow you to select the particular branch in the given
> repository, defaulting to the "master" branch.

Please don't use '!', several bash(1) versions just can't seem to get the
fact that '!' is quoted and try to do history expansion all over the place.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
