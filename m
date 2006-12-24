Return-Path: <linux-kernel-owner+w=401wt.eu-S1753015AbWLXWB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbWLXWB1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 17:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963AbWLXWB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 17:01:27 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:59196 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbWLXWB1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 17:01:27 -0500
Date: Sun, 24 Dec 2006 23:01:15 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061224220114.GA6256@deprecation.cyrius.com>
References: <20061222192027.GJ4229@deprecation.cyrius.com> <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061224005752.937493c8.akpm@osdl.org> <1166962478.7442.0.camel@localhost> <20061224043102.d152e5b4.akpm@osdl.org> <1166978752.7022.1.camel@localhost> <Pine.LNX.4.64.0612240907180.3671@woody.osdl.org> <97a0a9ac0612241127u1051f7eay70065b03f27ae668@mail.gmail.com> <Pine.LNX.4.64.0612241131570.3671@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612241131570.3671@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [2006-12-24 11:35]:
> And if this doesn't fix it, I don't know what will..

Sorry, but it still fails (on top of plain 2.6.19).
-- 
Martin Michlmayr
http://www.cyrius.com/
