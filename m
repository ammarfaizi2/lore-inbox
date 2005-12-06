Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbVLFBUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbVLFBUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 20:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964897AbVLFBUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 20:20:34 -0500
Received: from mail-haw.bigfish.com ([12.129.199.61]:10655 "EHLO
	mail28-haw-R.bigfish.com") by vger.kernel.org with ESMTP
	id S964828AbVLFBUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 20:20:33 -0500
X-BigFish: V
Message-ID: <4394E750.8020205@am.sony.com>
Date: Mon, 05 Dec 2005 17:20:16 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206005341.GN28539@opteron.random>
In-Reply-To: <20051206005341.GN28539@opteron.random>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Dec 05, 2005 at 03:56:06PM -0800, Tim Bird wrote:
> 
>>If the GPL covers interface linkages (whether static or
>>dynamic) then EXPORT_SYMBOL_GPL is redundant.  If it does
>>not, in all cases, then EXPORT_SYMBOL_GPL is, as
>>an extension to GPL, therefore a GPL violation.
> 
> The last time I spoke with Linus about this, what I understood can be
> described in two points:
> 
> 1) EXPORT_SYMBOL_GPL is an hint: if you have to circumvent it, there are
> high chances that you're creating a derivative of the linux kernel and
> in turn there are high chances that you're illegal
> 
> 2) The fact you're illegal or not, has nothing to do with the _GPL tag
> in the exports, the illegal usage is when the module create a derivative
> of the linux kernel.
> 
> Now I don't know for sure myself (I'm not a lawyer) what is a derivative
> of the linux kernel (don't ask me), but the two above points are quite
> clear to me. 

This interpretation puts kernel developers in the
position of making the legal decision about which
interfaces cause derivate-work risk and which
do not.  That's hardly a recipe for legal clarity.
(Not that legal clarity is a goal of Linux
kernel development... :-)
Different developers are likely to have
different viewpoints on which interfaces pose risks.
I guess Linus gets the last call (as usual),
so there's some possibility of some amount
of uniformity here.

Most kernel developers will naturally tend
towards making more symbols EXPORT_SYMBOL_GPL,
whether there's valid legal basis for it or not.
(Please let me know if there's a lawyer somewhere
reviewing the insertion of EXPORT_SYMBOL_GPLs)
David currently suggests that *all* interfaces
be so designated.  I suspect he strongly believes
that any use of a kernel interface creates a
derivative work.  I have a different opinion.

...

> The _GPL tag is useful as an hint to binary only vendors as as such it
> makes perfect sense.
Well, if it makes sense to have developers giving out legal
advice, then I guess so.

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================

