Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269775AbUJMS0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269775AbUJMS0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 14:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269776AbUJMS0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 14:26:34 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:25757 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S269775AbUJMS0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 14:26:33 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: single linked list header in kernel?
Date: Wed, 13 Oct 2004 20:25:43 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.13.18.25.41.367757@smurf.noris.de>
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de> <416D4255.9080501@nortelnetworks.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1097691943 506 192.109.102.35 (13 Oct 2004 18:25:43 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Wed, 13 Oct 2004 18:25:43 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chris Friesen wrote:

> There are various places where there are open-coded single-linked list 
> implementations.  This would just unify them to a single implementation.  On a 
> previous occasion, someone estimated 42 instances where slist_for_each() could 
> be used in net/core alone.
> 
So, if that bothers you, you should write a generic SLL, and convert a
couple of existing singly-linked lists to it as a proof-of-concept.

I dunno, though -- open-coding a singly-linked list isn't that much of a
problem; compared to a doubly-linked one, there's simply fewer things that
can go horribly wrong. :-/

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

