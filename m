Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbTKITa1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 14:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262788AbTKITa0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 14:30:26 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:47629 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262787AbTKITaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 14:30:21 -0500
Date: Sun, 9 Nov 2003 20:29:54 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>
Subject: Re: Some thoughts about stable kernel development
Message-ID: <20031109192954.GB1094@alpha.home.local>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Something like this has already been proposed a few times in the past (even
recent past), and I'm also all for a real permanently stable release which
only fixes bugs and vulnerabilities of the previous release. But there were
some massive objections, amongst others (IIRC) :

  - maintaining two trees is always more work than only one tree for the
    same person, whatever the changes. This is obviously true, otherwise
    none of us would ask for someone else to maintain the stable tree :-)
    I believe this reason was given by both Alan and Marcelo at different
    times.

  - I think it was Linus who said that clueless people will only use distro's
    kernels, therefore are not affected by how the kernel is developped. And
    for other people like us, the "stable" kernel will never contain enough
    features and we will have to patch anyway.

  - someone else (alan ?) said that even most obvious fixes can break some
    setups, so there are not many "obviously riskless" patches around, and
    if there's a really critical one which needs to go mainstream very quickly,
    then the maintainer can always release a new version in a hurry and delay
    -preX pending features for the next release.

I too would love to see frequent releases of bug fixes only, but I can admit
that it would not be fair to ask a handful of people to do more work just to
serve a few hundreds of lazy or busy people around. And BTW, there are now
people trying to maintain parallel bugfixes-only branches. Take a look at
James Bourne's site : http://www.hardrock.org/kernel/current-updates/

As long as individual patches are easily available, it's not too hard for
us to integrate them into our kernels.

Regards,
Willy

