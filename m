Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbTKLPHl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 10:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTKLPHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 10:07:41 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:14527 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S262156AbTKLPHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 10:07:38 -0500
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
References: <m3u15de669.fsf@defiant.pm.waw.pl>
	<20031109192954.GB1094@alpha.home.local>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 12 Nov 2003 16:01:20 +0100
In-Reply-To: <20031109192954.GB1094@alpha.home.local>
Message-ID: <m3n0b18wcf.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> writes:

>   - maintaining two trees is always more work than only one tree for the
>     same person, whatever the changes. This is obviously true, otherwise
>     none of us would ask for someone else to maintain the stable tree :-)
>     I believe this reason was given by both Alan and Marcelo at different
>     times.

Sure. However, with this scenario, the amount of additional work would be
low, as the time-consuming things are done once for both trees.

>   - I think it was Linus who said that clueless people will only use distro's
>     kernels, therefore are not affected by how the kernel is developped. And
>     for other people like us, the "stable" kernel will never contain enough
>     features and we will have to patch anyway.

Not sure about it - while I'm using 2.6.0test on my notebook (my personal
news/mail server + less important things), I also use official kernels
on some machines and patched trees on other ones.
What I _don't_ use is distribution kernel - not because it's bad, but
rather because i don't know it good enough.

>   - someone else (alan ?) said that even most obvious fixes can break some
>     setups, so there are not many "obviously riskless" patches around, and
>     if there's a really critical one which needs to go mainstream very
> quickly,
>     then the maintainer can always release a new version in a hurry and delay
>     -preX pending features for the next release.

-post, yes. But it only solves this one problem.
-- 
Krzysztof Halasa, B*FH
