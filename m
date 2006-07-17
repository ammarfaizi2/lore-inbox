Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWGRAAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWGRAAi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 20:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWGRAAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 20:00:37 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:6609 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751245AbWGRAAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 20:00:36 -0400
Message-Id: <200607171901.k6HJ1Zxa003239@laptop11.inf.utfsm.cl>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Diego Calleja <diegocg@gmail.com>, arjan@infradead.org,
       caleb@calebgray.com, linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion 
In-Reply-To: Your message of "Mon, 17 Jul 2006 16:31:06 +0200."
             <Pine.LNX.4.63.0607171611080.10427@alpha.polcom.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 17 Jul 2006 15:01:35 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 17 Jul 2006 19:59:15 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> wrote:

[...]

> Why do some people think that users are not already depending on it? 
> They are.

Foolishly, perhaps...

>           I don't know how much but I am willing to bet that at least
> 100 people. I think that there are some drivers in the kernel that
> have smaller user base.

Feel free to suggest deleting said drivers.

> Keeping Reiser4 out of kernel is even worse (for those users, other
> users that could test this filesystem, for Reiser4 developers and
> whole comunity) than accepting it for a try period with a big fat
> warning that it my be removed if Namesys abandons futher fixing of it
> (after some time to let user migrate).

I just won't work that way. Using that logic, Reiser 3 should be gone long
ago...

> And any arguments like "if Reiser4 is not in the kernel then people
> will not use and depend on it" are fundamentally flawed
> IMHO. Everything bad that could happen with Reiser4 in the kernel can
> happen with Reiser4 out of it.

Right. But this way it is /not/ the kernel crowd's job to look after it.

> It may look like some kernel developers are trying hard not to take
> responsibility for Reiser4

Why should they? They don't feel confortable with the code, believe it has
fatal design (and other) problems. Its maintainers have shown a tendency to
disregard data safety, and just dump the code when something new fancies
them. The kernel hackers can't just take over any random piece of complex
code, the only scalable way of integrating new stuff that will stay for a
/long/ time is to have reasonable expectations that whoever proposes the
code will stay around maintaining it.

>                            saying that there is very huge difference
> between selecting highly experimental kernel feature that is marked so
> and patching the kernel with it. Sorry but I think there is very
> little difference. And that little difference is only hurting users
> that want to try and test something new.

If it is in the kernel, the expectation is that it will stay in the kernel
for the foreseeable future. For a filesystem, something like the next 10
years. Thus letting in a new filesystem is a /huge/ commitment.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
