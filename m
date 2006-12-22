Return-Path: <linux-kernel-owner+w=401wt.eu-S1946002AbWLVKGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946002AbWLVKGs (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946017AbWLVKGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:06:48 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:53663 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946002AbWLVKGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:06:48 -0500
Date: Fri, 22 Dec 2006 11:06:37 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061222100637.GA12105@deprecation.cyrius.com>
References: <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com> <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com> <20061221012721.68f3934b.akpm@osdl.org> <97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com> <Pine.LNX.4.64.0612212033120.3671@woody.osdl.org> <20061222100004.GC10273@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061222100004.GC10273@deprecation.cyrius.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Martin Michlmayr <tbm@cyrius.com> [2006-12-22 11:00]:
> This time, however, I let the installer continue and it seems that
> with your patch apt now works where it failed in the past, but it
> hangs later on.  It's pretty weird because I cannot even kill the
> process:

Okay, it's really weird.  So apt-get just hangs doing nothing and I
cannot even kill it.  I just tried to download strace via wget and
immediately when I started wget, the hanging apt-get process
continued.
-- 
Martin Michlmayr
http://www.cyrius.com/
