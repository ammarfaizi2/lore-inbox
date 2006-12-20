Return-Path: <linux-kernel-owner+w=401wt.eu-S1030277AbWLTUXf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030277AbWLTUXf (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWLTUXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:23:35 -0500
Received: from amsfep20-int.chello.nl ([62.179.120.15]:47616 "EHLO
	amsfep20-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030277AbWLTUXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:23:34 -0500
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
	corruption on ext3)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Martin Michlmayr <tbm@cyrius.com>, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrei Popa <andrei.popa@i-neo.ro>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
In-Reply-To: <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
References: <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
	 <1166571749.10372.178.camel@twins>
	 <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org>
	 <1166605296.10372.191.camel@twins>
	 <1166607554.3365.1354.camel@laptopd505.fenrus.org>
	 <1166614001.10372.205.camel@twins>
	 <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com>
	 <1166622979.10372.224.camel@twins>
	 <20061220170323.GA12989@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612200928090.6766@woody.osdl.org>
	 <20061220175309.GT30106@deprecation.cyrius.com>
	 <Pine.LNX.4.64.0612201043170.6766@woody.osdl.org>
	 <Pine.LNX.4.64.0612201139280.3576@woody.osdl.org>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 21:22:03 +0100
Message-Id: <1166646123.10372.241.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 11:50 -0800, Linus Torvalds wrote:

> Nick, Hugh, Peter, Andrew? Comments? 

Hooray! I'm all for this cleanup. Let us see where this road leads..



