Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267405AbUHXKeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267405AbUHXKeg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267429AbUHXKeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:34:36 -0400
Received: from dns1.seagha.com ([217.66.0.18]:11238 "EHLO ndns1.seagha.com")
	by vger.kernel.org with ESMTP id S267405AbUHXKe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:34:26 -0400
Message-ID: <6DED3619289CD311BCEB00508B8E133601A68B20@nt-server2.antwerp.seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: RE: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
Date: Tue, 24 Aug 2004 12:35:28 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The tests of yesterday evening, did recover. So I'm 
> guessing if I had
> > waited long enough the box would have recovered on the previous
> > tests. Looking at the vmstat from my previous tests, shows that the
> > box was low on memory (free/buff/cache are all very low):
> > 
> >   http://users.telenet.be/kvogel/vmstat-after-kill.txt
> > 
> > That was probably why it was swapping like mad. 
> 
> Ok, so now I'm confused - tests on what kernel recovered?

2.6.8.1 with voluntary-preempt-P7

The same kernel as the one that didn't recover (waited 10 minutes,
after which it was still swapping like mad).

Ofcourse the test where it recovered was when nothing else was
running on the box (no X session, no KDE, just plain 'init 3').

Karl.
