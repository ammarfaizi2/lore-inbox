Return-Path: <linux-kernel-owner+w=401wt.eu-S1161078AbWLUAZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161078AbWLUAZO (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWLUAZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:25:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52550 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161078AbWLUAZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:25:11 -0500
Date: Wed, 20 Dec 2006 16:24:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Martin Michlmayr <tbm@cyrius.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
In-Reply-To: <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
Message-ID: <Pine.LNX.4.64.0612201622480.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
 <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org>
 <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
 <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com>
 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org> <20061220153207.b2a0a27f.akpm@osdl.org>
 <Pine.LNX.4.64.0612201548410.3576@woody.osdl.org> <20061220161158.acb77ce6.akpm@osdl.org>
 <Pine.LNX.4.64.0612201615590.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Btw, I'd really love to hear whether the patch I sent out actually _helps_ 
at all, or whether we're just discussing something that in the end is just 
a cleanup..

Martin, Peter, Andrei, pls give it a try. (Martin and Andrei may be 
talking about different bugs, so _both_ of your experiences definitely 
matter here).

		Linus
