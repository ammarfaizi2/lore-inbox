Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWFWSJu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWFWSJu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWFWSJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:09:50 -0400
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:47011 "EHLO
	mail-gw1.sa.eol.hu") by vger.kernel.org with ESMTP id S1751858AbWFWSJt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:09:49 -0400
To: torvalds@osdl.org
CC: hugh@veritas.com, a.p.zijlstra@chello.nl, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de
In-reply-to: <Pine.LNX.4.64.0606231042350.6483@g5.osdl.org> (message from
	Linus Torvalds on Fri, 23 Jun 2006 10:49:15 -0700 (PDT))
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
References: <20060619175243.24655.76005.sendpatchset@lappy> 
 <20060619175253.24655.96323.sendpatchset@lappy> 
 <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com>
 <1151019590.15744.144.camel@lappy> <Pine.LNX.4.64.0606222305210.6483@g5.osdl.org>
 <Pine.LNX.4.64.0606230759480.19782@blonde.wat.veritas.com> <Pine.LNX.4.64.0606231042350.6483@g5.osdl.org>
Message-Id: <E1Ftq54-0002Og-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 23 Jun 2006 20:08:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I've got two reasons to want to fast-track it:
> 
>  - it's exactly what I wanted to see, so I'm obviously personally happy 
>    with the patch

Heh, IIRC you rejected the idea of doing a fault on dirtying for
performance reasons, during the discussion of VM deadlocks in FUSE.

Anyway, I'm more than happy, since David and Peter basically solved
the problem, so shared writable mappings should now be possible to do.

Miklos
