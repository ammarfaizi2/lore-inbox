Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVAYUZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVAYUZv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbVAYUZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:25:51 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:12221 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262112AbVAYUZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:25:46 -0500
Date: Tue, 25 Jan 2005 15:25:01 -0500
To: John Richard Moser <nigelenki@comcast.net>
Cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050125202501.GA21764@fieldses.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org> <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com> <41F6A45D.1000804@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6A45D.1000804@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 02:56:13PM -0500, John Richard Moser wrote:
> In this context, it doesn't make sense to deploy a protection A or B
> without the companion protection, which is what I meant.

But breaking up the introduction of new code into logical steps is still
helpful for people trying to understand the new code.

Even if it's true that it's no use locking any door until they are all
locked, there's still some value to allowing people to watch you lock
each door individually.  It's easier for them to understand what you're
doing that way.

--Bruce Fields
