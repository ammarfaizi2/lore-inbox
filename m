Return-Path: <linux-kernel-owner+w=401wt.eu-S964904AbWLULVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWLULVY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 06:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964845AbWLULVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 06:21:24 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:50948 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964904AbWLULVX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 06:21:23 -0500
Date: Thu, 21 Dec 2006 12:21:14 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061221112114.GO19098@deprecation.cyrius.com>
References: <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins> <20061220170323.GA12989@deprecation.cyrius.com> <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org> <20061220175309.GT30106@deprecation.cyrius.com> <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org> <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org> [2006-12-20 11:50]:
> Martin, Andrei, does this make any difference for your corruption
> cases?

Works for me.
-- 
Martin Michlmayr
http://www.cyrius.com/
