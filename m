Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264268AbTLJXiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:38:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLJXiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:38:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:43659 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264268AbTLJXiN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:38:13 -0500
Date: Wed, 10 Dec 2003 15:38:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Kendall Bennett <KendallB@scitechsoft.com>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031210221800.GM6896@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312101535170.1273@home.osdl.org>
References: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
 <3FD7081D.31093.61FCFA36@localhost> <20031210221800.GM6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 10 Dec 2003, Larry McVoy wrote:
>
> Not only that, I think the judge would have something to say about the
> fact that the modules interface is delibrately changed all the time
> with stated intent of breaking binary drivers.

Where do you people _find_ these ideas?

We don't "deliberately change the interfaces to make modules harder".

Rather, we deliberately don't _care_ about binary modules, exactly because
we have documented several times that it IS NOT AN API.

So what we do is to change the interfaces when it makes sense to change
them (ie we do have a real reason to do so), and we deliberately make
people AWARE of this fact.

See the difference?

The internal kernel module interface is clearly documented to be
_internal_ over several years of discussions (this particular discussion
seems to come up once every year or so). It's not an API, and never has
been.

But we don't change the interfaces just to be difficult.

			Linus
