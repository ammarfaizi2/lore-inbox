Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbUK3WWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbUK3WWx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 17:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262353AbUK3WWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 17:22:53 -0500
Received: from fw.osdl.org ([65.172.181.6]:35200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262361AbUK3WWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 17:22:50 -0500
Date: Tue, 30 Nov 2004 14:22:33 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
 <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Nov 2004, Alexandre Oliva wrote:
> 
> Then maybe this is the fundamental problem.  As long as the kernel
> doesn't recognize that an ABI is a contract, rather than an
> imposition, kernel developers won't care.

That's a silly analogy. Worse, it's a very flawed analogy.

If you want to use a legal analogy, the ABI is not a contract, it's a
public _license_.

Why? A contract is something that you cannot change unilaterally. Clearly
the kernel _can_ and will change the ABI without asking every existing
program for permission.

In a license, you can always just _expand_ the license eventually. Maybe
you originally licensed for "fly-fishing for trout", and later you can
expand that license to say "you can also catch crawfish" without impacting
your existing licensees.

And exactly as with an ABI, the only thing you can't do is _remove_ rights 
without getting into trouble. 

So get your analogies straight. The kernel ABI is _not_ a contract. 

		Linus
