Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUK3W6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUK3W6t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUK3W6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:58:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:5277 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262393AbUK3Wzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:55:44 -0500
Date: Tue, 30 Nov 2004 14:55:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Matt Mackall <mpm@selenic.com>
cc: David Woodhouse <dwmw2@infradead.org>, Alexandre Oliva <aoliva@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <20041130224851.GH8040@waste.org>
Message-ID: <Pine.LNX.4.58.0411301452180.22796@ppc970.osdl.org>
References: <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <1101828924.26071.172.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0411300751570.22796@ppc970.osdl.org>
 <1101832116.26071.236.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0411300846190.22796@ppc970.osdl.org>
 <1101837135.26071.380.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0411301020160.22796@ppc970.osdl.org> <20041130224851.GH8040@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Matt Mackall wrote:
> 
> So we follow dhowell's plan with the following additions:

No.

We do _not_ move stuff over that is questionable.

I thought that was clear by now. The rules are:
 - we only move things that _have_ to move
 - we don't break existing programs, and no "but they are broken already" 
   is not an excuse.
 - we only move things where that _particular_ move can be shown to be 
   beneficial.

No whole-sale moves. No "let's break things that I think are broken". No 
"let's change things because we can".

Well-defined moves. Both in content _and_ in reason.

		Linus
