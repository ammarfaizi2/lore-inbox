Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVATXqB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVATXqB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 18:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbVATXpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 18:45:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:11724 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262215AbVATXpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 18:45:47 -0500
Date: Thu, 20 Jan 2005 15:45:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Peter Chubb <peterc@gelato.unsw.edu.au>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org, tony.luck@intel.com,
       dsw@gelato.unsw.edu.au, benh@kernel.crashing.org,
       linux-ia64@vger.kernel.org, hch@infradead.org, wli@holomorphy.com,
       jbarnes@sgi.com
Subject: Re: [patch, BK-curr] nonintrusive spin-polling loop in kernel/spinlock.c
In-Reply-To: <20050120182227.GA26985@elte.hu>
Message-ID: <Pine.LNX.4.58.0501201538320.8178@ppc970.osdl.org>
References: <20050120023445.GA3475@taniwha.stupidest.org>
 <20050119190104.71f0a76f.akpm@osdl.org> <20050120031854.GA8538@taniwha.stupidest.org>
 <16879.29449.734172.893834@wombat.chubb.wattle.id.au>
 <Pine.LNX.4.58.0501200747230.8178@ppc970.osdl.org> <20050120160839.GA13067@elte.hu>
 <Pine.LNX.4.58.0501200823010.8178@ppc970.osdl.org> <20050120164038.GA15874@elte.hu>
 <Pine.LNX.4.58.0501200947440.8178@ppc970.osdl.org> <20050120175313.GA22782@elte.hu>
 <20050120182227.GA26985@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Btw, I think I've now merged everything to bring us back to where we 
wanted to be - can people verify that the architecture they care about has 
all the right "read_can_lock()" etc infrastructure (and preferably that it 
_works_ too ;), and that I've not missed of incorrectly ignored some 
patches in this thread?

		Linus
