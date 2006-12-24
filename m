Return-Path: <linux-kernel-owner+w=401wt.eu-S1751627AbWLXOFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbWLXOFr (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 09:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751632AbWLXOFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 09:05:47 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:58443 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbWLXOFq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 09:05:46 -0500
Date: Sun, 24 Dec 2006 15:05:28 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Andrei Popa <andrei.popa@i-neo.ro>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061224140528.GF28755@deprecation.cyrius.com>
References: <20061222100004.GC10273@deprecation.cyrius.com> <20061222021714.6a83fcac.akpm@osdl.org> <1166790275.6983.4.camel@localhost> <20061222123249.GG13727@deprecation.cyrius.com> <20061222125920.GA16763@deprecation.cyrius.com> <1166793952.32117.29.camel@twins> <20061222192027.GJ4229@deprecation.cyrius.com> <97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com> <Pine.LNX.4.64.0612240029390.3671@woody.osdl.org> <20061224005752.937493c8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061224005752.937493c8.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@osdl.org> [2006-12-24 00:57]:
>   /etc/fstab: ext2 nobh
>   /etc/fstab: ext3 data=writeback,nobh

It seems that busybox mount ignores the nobh option but both ext2 and
ext3 data=writeback work for me.  This is with plain 2.6.19 which
normally always fails.
-- 
Martin Michlmayr
http://www.cyrius.com/
