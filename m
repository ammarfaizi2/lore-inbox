Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbULAAr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbULAAr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 19:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbULAAeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 19:34:14 -0500
Received: from canuck.infradead.org ([205.233.218.70]:18186 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261245AbULAAZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 19:25:21 -0500
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
From: David Woodhouse <dwmw2@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, dhowells <dhowells@redhat.com>,
       Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       Matthew Wilcox <matthew@wil.cx>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
In-Reply-To: <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
References: <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
	 <19865.1101395592@redhat.com>
	 <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
	 <1101406661.8191.9390.camel@hades.cambridge.redhat.com>
	 <20041127032403.GB10536@kroah.com>
	 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
	 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <8219.1101828816@redhat.com>
	 <Pine.LNX.4.58.0411300744120.22796@ppc970.osdl.org>
	 <ormzwzrrmy.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301249590.22796@ppc970.osdl.org>
	 <orekibrpmn.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <Pine.LNX.4.58.0411301423030.22796@ppc970.osdl.org>
	 <1101854061.4574.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301447570.22796@ppc970.osdl.org>
	 <1101858657.4574.33.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0411301605500.22796@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 01 Dec 2004 00:24:47 +0000
Message-Id: <1101860688.4574.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 16:10 -0800, Linus Torvalds wrote:
> I'll draw it at "somebody might validly use it", because the fact is, I 
> can't test it. 
> 
> Which is why I want patches to this to be OBVIOUSLY CORRECT, dammit! How 
> hard is that to understand?

The concept isn't at all hard to understand. But no patch is 'obviously
correct' if you want to protect against the _slightest_ possibility that
people might be abusing something you're taking away. 

Some people might define __KERNEL__ on purpose when compiling something
in userspace, to get something that would otherwise be hidden from them.
Would you consider that sacrosanct too?

-- 
dwmw2

