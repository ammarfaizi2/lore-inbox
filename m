Return-Path: <linux-kernel-owner+w=401wt.eu-S1422948AbWLUJAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422948AbWLUJAt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 04:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423001AbWLUJAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 04:00:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50803 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423003AbWLUJAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 04:00:46 -0500
Date: Thu, 21 Dec 2006 00:59:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Martin Michlmayr <tbm@cyrius.com>
cc: Gordon Farquharson <gordonfarquharson@gmail.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <20061221083801.GB4674@deprecation.cyrius.com>
Message-ID: <Pine.LNX.4.64.0612210058510.3394@woody.osdl.org>
References: <1166614001.10372.205.camel@twins>
 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
 <97a0a9ac0612202332p1b90367bja28ba58c653e5cd5@mail.gmail.com>
 <Pine.LNX.4.64.0612202352060.3576@woody.osdl.org> <20061221083801.GB4674@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Dec 2006, Martin Michlmayr wrote:
> 
> This is a known issue.  The following patch has been proposed
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4030/1
> although I just notice that it has been marked as "discarded".
> Apparently Russell King commited a better patch so this should be
> fixed in git when he sends his next pull request.

Ahh, ok. Then it might even be in the set of merges I did earlier today 
(and which should mirror out soon enough, hopefully).

		Linus
