Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbUCSLwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 06:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262806AbUCSLwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 06:52:17 -0500
Received: from main.gmane.org ([80.91.224.249]:60069 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262762AbUCSLwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 06:52:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [PATCH] Driver Core update for 2.6.4
Date: Fri, 19 Mar 2004 12:52:11 +0100
Message-ID: <MPG.1ac4fd5af26bf26b989689@news.gmane.org>
References: <1AajM-5vw-21@gated-at.bofh.it> <1Abpq-6Av-1@gated-at.bofh.it> <1Aj3K-5Fn-9@gated-at.bofh.it> <1AjwZ-65D-15@gated-at.bofh.it> <m3brmwojk8.fsf@averell.firstfloor.org> <20040319091722.GD2650@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: oblomov.dipmat.unict.it
X-Newsreader: MicroPlanet Gravity v2.60
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Andi Kleen wrote:
> > > eh?  If there is any argument against this code it is that it is so simple
> > > that the thing which it abstracts is not worth abstracting.  But given that
> > > it is so unwasteful, this seems unimportant.
> > 
> > The bloat argument was about the additional pointer in the dynamic 
> > data structure (on a 64bit architecture it costs 12 bytes) 
> 
> This is one place where C++-style vtable inheritance would help.
> Many of those *_operations tables could logically derive from a kref_operations table.
> 
> I doubt if there is a nice to way to represent it with C macros, but
> maybe there is.

(Stupid idea) Has anybody thought about using "Lightweight C++"?

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

