Return-Path: <linux-kernel-owner+w=401wt.eu-S965148AbWLTRDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965148AbWLTRDy (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 12:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbWLTRDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 12:03:54 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:48306 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965148AbWLTRDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 12:03:53 -0500
Date: Wed, 20 Dec 2006 18:03:23 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Hugh Dickins <hugh@veritas.com>, Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrei Popa <andrei.popa@i-neo.ro>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>, gordonfarquharson@gmail.com
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content corruption on ext3)
Message-ID: <20061220170323.GA12989@deprecation.cyrius.com>
References: <Pine.LNX.4.64.0612181114160.3479@woody.osdl.org> <1166471069.6940.4.camel@localhost> <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org> <1166571749.10372.178.camel@twins> <Pine.LNX.4.64.0612191609410.6766@woody.osdl.org> <1166605296.10372.191.camel@twins> <1166607554.3365.1354.camel@laptopd505.fenrus.org> <1166614001.10372.205.camel@twins> <Pine.LNX.4.64.0612201237280.28787@blonde.wat.veritas.com> <1166622979.10372.224.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166622979.10372.224.camel@twins>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Zijlstra <a.p.zijlstra@chello.nl> [2006-12-20 14:56]:
> page_mkclean_one() fix

This patch doesn't fix my problem (apt segfaults on ARM because its
database is corrupted).
-- 
Martin Michlmayr
http://www.cyrius.com/
