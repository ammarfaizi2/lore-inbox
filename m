Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbTLJSDF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbTLJSDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:03:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:64141 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263796AbTLJSDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:03:02 -0500
Date: Wed, 10 Dec 2003 10:02:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Larry McVoy <lm@bitmover.com>
cc: Andre Hedrick <andre@linux-ide.org>, Arjan van de Ven <arjanv@redhat.com>,
       Valdis.Kletnieks@vt.edu, Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <20031210175614.GH6896@work.bitmover.com>
Message-ID: <Pine.LNX.4.58.0312100959180.29676@home.osdl.org>
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org>
 <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com>
 <Pine.LNX.4.58.0312100852210.29676@home.osdl.org> <20031210175614.GH6896@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 10 Dec 2003, Larry McVoy wrote:
>
> I see.  And your argument, had it prevailed 5 years ago, would have
> invalidated the following, would it not?  The following from one of the
> Microsoft lawsuits.

No it wouldn't.

Microsoft very much _has_ a binary API to their drivers, in a way that
Linux doesn't.

MS has to have that binary API exactly because they live in a binary-only
world. They've basically put that requirement on themselves by having
binary-only distributions.

So your argument doesn't fly. To Microsoft, a "driver" is just another
external entity, with documented API's, and they indeed ship their _own_
drivers that way too. And all third-party drivers do the same thing.

So there is no analogy to the Linux case. In Linux, no fixed binary API
exists, and the way normal drivers are distributed are as GPL'd source
code.

			Linus
