Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbVJSLSf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbVJSLSf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 07:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964795AbVJSLSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 07:18:35 -0400
Received: from khc.piap.pl ([195.187.100.11]:31748 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S964798AbVJSLSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 07:18:34 -0400
To: Rudolf Polzer <debian-ne@durchnull.de>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain>
	<20051018171645.GA59028%atfield-dt@durchnull.de>
	<m3fyqyhdm8.fsf@defiant.localdomain>
	<20051018204919.GA21286%atfield-dt@durchnull.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 19 Oct 2005 13:18:32 +0200
In-Reply-To: <20051018204919.GA21286%atfield-dt@durchnull.de> (Rudolf
 Polzer's message of "Tue, 18 Oct 2005 22:49:19 +0200")
Message-ID: <m3oe5l21rr.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Polzer <debian-ne@durchnull.de> writes:

> However, pool computers like in this case are neither servers nor terminals.
> If they were terminals, we would need about 30 servers to handle the load of
> 100 active students. So they are workstation installations that do most of
> the
> work locally.

Ok. So they are exposed to known attacks with quite high probability.
This might be acceptable (as they are student machines) but not secure.

>> Hope they don't change the keys in the process.
>
> They HAVE to do that,

Well, I meant physical keys to match them to loaded keymaps :-)

> Many people here need that, but it's ok for them if it works only in X11
> (most
> of these users don't even know that text consoles exist).

I see. X11 is another story, though.

> However, Xorg and XFree86 have about the same problem: you can remap
> Ctrl-Alt-Backspace. So it would be good if the SAK also worked there which
> would require it to set a "sane" video mode.

I assume that one can notice that Ctrl-Alt-Backspace doesn't work,
and stop there. I think SAK/X11 video mode issue is possible to fix,
though.
-- 
Krzysztof Halasa
