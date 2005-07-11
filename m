Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261813AbVGKRYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbVGKRYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbVGKRWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:22:19 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:5009 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S261719AbVGKRUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:20:36 -0400
Message-Id: <200507111718.j6BHI7RI001885@laptop11.inf.utfsm.cl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Pekka Enberg <penberg@cs.helsinki.fi>,
       Roman Zippel <zippel@linux-m68k.org>,
       Bryan Henderson <hbryan@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum 
In-Reply-To: Message from Vojtech Pavlik <vojtech@suse.cz> 
   of "Sun, 10 Jul 2005 21:16:07 +0200." <20050710191607.GA4102@ucw.cz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Date: Mon, 11 Jul 2005 13:18:07 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 11 Jul 2005 13:18:07 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Sun, Jul 10, 2005 at 09:21:42PM +0300, Pekka Enberg wrote:
> > Hmm. So we disagree on that issue as well. I think the point of review
> > is to improve code and help others conform with the existing coding
> > style which is why I find it strange that you're suggesting me to limit
> > my comments to a subset you agree with.
> > 
> > Would you please be so kind to define your criteria for things that
> > "need fixing" so we could see if can reach some sort of an agreement on
> > this. My list is roughly as follows:
> > 
> >   - Erroneous use of kernel API
> >   - Bad coding style
> >   - Layering violations
> >   - Duplicate code
> >   - Hard to read code

> The reason people post their patches for review is to get good feedback
> on them. The problems you list above are mostly nitpicks. They must be
> fixed before inclusion of the patch, but only make sense to start fixing
> once the patch does a reasonable change.

If the coding style is an obstacle to understanding, it has to be fixed if
there is going to be any kind of review. Besides, nitpicks being simple to
address, they could as well be fixed while at it. Perhaps that way the
author learns to do it right, and less nitpicks are left in later additions
and fixes.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
