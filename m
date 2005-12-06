Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbVLFAxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbVLFAxp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 19:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbVLFAxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 19:53:44 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:41557
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S964890AbVLFAxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 19:53:44 -0500
Date: Tue, 6 Dec 2005 01:53:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Tim Bird <tim.bird@am.sony.com>
Cc: David Woodhouse <dwmw2@infradead.org>, arjan@infradead.org,
       andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206005341.GN28539@opteron.random>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394D396.1020102@am.sony.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 03:56:06PM -0800, Tim Bird wrote:
> If the GPL covers interface linkages (whether static or
> dynamic) then EXPORT_SYMBOL_GPL is redundant.  If it does
> not, in all cases, then EXPORT_SYMBOL_GPL is, as
> an extension to GPL, therefore a GPL violation.

The last time I spoke with Linus about this, what I understood can be
described in two points:

1) EXPORT_SYMBOL_GPL is an hint: if you have to circumvent it, there are
high chances that you're creating a derivative of the linux kernel and
in turn there are high chances that you're illegal

2) The fact you're illegal or not, has nothing to do with the _GPL tag
in the exports, the illegal usage is when the module create a derivative
of the linux kernel.

Now I don't know for sure myself (I'm not a lawyer) what is a derivative
of the linux kernel (don't ask me), but the two above points are quite
clear to me. 

I always thought the _GPL tag could have no direct legal implications
and Linus confirmed it. The kernel is GPL so everyone can modify the
exports or re-export symbols as usual, the exports are GPL code too. The
guy who re-exports or remove a _GPL tag is just modifying a GPL code, so
he's ok.

The _GPL tag is useful as an hint to binary only vendors as as such it
makes perfect sense.
