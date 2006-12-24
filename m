Return-Path: <linux-kernel-owner+w=401wt.eu-S1752663AbWLXUZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbWLXUZK (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 15:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbWLXUZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 15:25:10 -0500
Received: from smtp.osdl.org ([65.172.181.25]:55232 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbWLXUZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 15:25:09 -0500
Date: Sun, 24 Dec 2006 12:24:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrei Popa <andrei.popa@i-neo.ro>
cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <1166991054.7033.2.camel@localhost>
Message-ID: <Pine.LNX.4.64.0612241224140.3671@woody.osdl.org>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> 
 <1166793952.32117.29.camel@twins>  <20061222192027.GJ4229@deprecation.cyrius.com>
  <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> 
 <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>  <20061224005752.937493c8.akpm@osdl.org>
 <1166962478.7442.0.camel@localhost>  <20061224043102.d152e5b4.akpm@osdl.org>
 <1166978752.7022.1.camel@localhost>  <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org>
  <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com> 
 <Pine.LNX.4.64.0612241131570.3671@woody.osdl.org> <1166991054.7033.2.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 24 Dec 2006, Andrei Popa wrote:
> 
> Hash check on download completion found bad chunks, consider using
> "safe_sync".

Dang. Did you get any warning messages from the kernel?

		Linus
