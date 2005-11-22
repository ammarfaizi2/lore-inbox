Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVKVTwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVKVTwe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965158AbVKVTwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:52:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:36746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965157AbVKVTwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:52:30 -0500
Date: Tue, 22 Nov 2005 11:51:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>,
       Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>,
       Ian Molton <spyro@f2s.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/5] Centralise NO_IRQ definition 
In-Reply-To: <10979.1132688330@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0511221145520.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0511221044340.13959@g5.osdl.org> 
 <Pine.LNX.4.64.0511220856470.13959@g5.osdl.org> <E1Ee0G0-0004CN-Az@localhost.localdomain>
 <24299.1132571556@warthog.cambridge.redhat.com> <20051121121454.GA1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211047260.13959@g5.osdl.org> <20051121190632.GG1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211124190.13959@g5.osdl.org> <20051121194348.GH1598@parisc-linux.org>
 <Pine.LNX.4.64.0511211150040.13959@g5.osdl.org> <20051121211544.GA4924@elte.hu>
 <17282.15177.804471.298409@cargo.ozlabs.ibm.com> <1132611631.11842.83.camel@localhost.localdomain>
 <1132657991.15117.76.camel@baythorne.infradead.org>
 <1132668939.20233.47.camel@localhost.localdomain> <9497.1132684676@warthog.cambridge.redhat.com>
  <10979.1132688330@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 22 Nov 2005, David Howells wrote:
> 
> The same could be said of Linux. The docs there could be a *lot* better.
> 
> I wonder... might it be worth creating a Wiki or something on kernel.org in
> which kernel docs can be maintained?

I'm not sure a wiki will save us, but I don't think we'd have anything to 
lose from trying. 

Whether kernel.org wants to have a wiki and the related infrastructure is 
another matter. Right now I think everything is set up so that the public 
machines are pure mirrors of the master machine, and the master machine 
doesn't allow any public interaction at all.

So the wiki would have to be a totally separate setup (probably a 
dedicated public wiki machine at "wiki.kernel.org" or something). 

IOW, I suspect it would be best set up the same way "vger.kernel.org" is, 
rather than necessarily any of the current core kernel.org machines. So 
maybe somebody can just try to set it up, and ask for the DNS magic to be 
done?

		Linus
