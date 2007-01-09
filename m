Return-Path: <linux-kernel-owner+w=401wt.eu-S932197AbXAIQX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbXAIQX0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 11:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbXAIQX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 11:23:26 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:33082 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932197AbXAIQX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 11:23:26 -0500
Message-Id: <200701091623.l09GNIsw009078@laptop13.inf.utfsm.cl>
To: Akula2 <akula2.shark@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Jumping into Kernel development: About -rc kernels... 
In-Reply-To: Message from Akula2 <akula2.shark@gmail.com> 
   of "Tue, 09 Jan 2007 21:03:58 +0530." <8355959a0701090733l74d03792q16b3022d949c7ae1@mail.gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
Date: Tue, 09 Jan 2007 13:23:18 -0300
From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Tue, 09 Jan 2007 13:23:19 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akula2 <akula2.shark@gmail.com> wrote:
> This question might sound dumb for many, and to some annoying too ;-)

It's OK if you don't do it too often ;-)

[...]

> I did understand till here. Should I start compile/test/debug
> one-after-one in this fashion:-
> 
> 2.6.19 source + patch-2.6.20-rc1
> 2.6.19 source + patch-2.6.20-rc2
> 2.6.19 source + patch-2.6.20-rc3
> 2.6.19 source + patch-2.6.20-rc4
> 
> OR
> 
> Pick the latest release number?

Pick the latest, it has bugs in earlier ones fixed. But it might have its
own ;-)

BTW, you can track the day-to-day development of the kernel (and other
stuff) using git, which has other nifty features (like being able to go
back to an earlier version, and even automate the finding of the broken
patch by narrowing down from a known good and a known bad version).

git is probably in your distribution, or you can get it (as source, or
prebuilt) from <http://kernel.org/pub/software/scm/git>, a bunch of
documentation is in the package itself or at <http://www.git.or.cz>.
<http://www.kernel.org> gives pointers to several git kernel repositories.

Good luck!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
