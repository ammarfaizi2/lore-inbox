Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbVAYSay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbVAYSay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVAYSay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:30:54 -0500
Received: from fw.osdl.org ([65.172.181.6]:21724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262053AbVAYSam (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:30:42 -0500
Date: Tue, 25 Jan 2005 10:30:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: John Richard Moser <nigelenki@comcast.net>
cc: Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
In-Reply-To: <41F68975.8010405@comcast.net>
Message-ID: <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu> <41F6604B.4090905@tmr.com>
 <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com>
 <41F68975.8010405@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Jan 2005, John Richard Moser wrote:
> 
> It's kind of like locking your front door, or your back door.  If one is
> locked and the other other is still wide open, then you might as well
> not even have doors.  If you lock both, then you (finally) create a
> problem for an intruder.
> 
> That is to say, patch A will apply and work without B; patch B will
> apply and work without patch A; but there's no real gain from using
> either without the other.

Sure there is. There's the gain that if you lock the front door but not 
the back door, somebody who goes door-to-door, opportunistically knocking 
on them and testing them, _will_ be discouraged by locking the front door.

Never mind that he still could have gotten in. After all, if you locked 
the back door too, he might still have a crow-bar.

It is a logically fallacy to think that "perfect" is good. It's not. 
Anybody who strives for perfection will FAIL. 

What's good is "incremental changes". Something that everybody and his dog 
can look at for five seconds and say "oh, that's obviously fine", and then 
can get more testing (because "everybody and his dog" saying "that's fine" 
doesn't actually prove much of anything).

This has nothing to do with security, btw. It's universally true. You get 
absolutely nowhere by trying to redesign the world. 

		Linus
