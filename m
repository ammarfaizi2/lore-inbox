Return-Path: <linux-kernel-owner+w=401wt.eu-S1751347AbWLVR1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWLVR1z (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWLVR1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:27:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59857 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbWLVR1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:27:54 -0500
Date: Fri, 22 Dec 2006 09:27:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-kernel@vger.kernel.org, Andrei Popa <andrei.popa@i-neo.ro>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>, Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Subject: Re: 2.6.19 file content corruption on ext3
In-Reply-To: <200612181734.01809.gene.heskett@verizon.net>
Message-ID: <Pine.LNX.4.64.0612220926390.3671@woody.osdl.org>
References: <1166314399.7018.6.camel@localhost> <Pine.LNX.4.64.0612181151010.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181230330.3479@woody.osdl.org> <200612181734.01809.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Gene Heskett wrote:
>
> What about the mm/rmap.c one liner, in or out?

The one that just removes the "pte_mkclean()"? That's definitely out, it 
was just a test-patch to verify that the pte dirty bits seemed to matter 
at all (and they do).

		Linus
