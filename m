Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbULBD6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbULBD6n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 22:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbULBD6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 22:58:43 -0500
Received: from fw.osdl.org ([65.172.181.6]:49540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261339AbULBD6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 22:58:40 -0500
Date: Wed, 1 Dec 2004 19:58:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alexandre Oliva <aoliva@redhat.com>
cc: Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
       David Woodhouse <dwmw2@infradead.org>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
Message-ID: <Pine.LNX.4.58.0412011948450.22796@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org>
 <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org>
 <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
 <oris7nrq0h.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301413260.22796@ppc970.osdl.org>
 <or4qj7rllv.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411301505580.22796@ppc970.osdl.org>
 <orvfbllsbe.fsf@livre.redhat.lsd.ic.unicamp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Dec 2004, Alexandre Oliva wrote:
> 
> > Then your definition of a "contract" is flawed or your world-view has 
> > nothing to do with reality.
> 
> It's not my definition, it's a definition used in software
> engineering. 

Not that I've seen. Maybe your school. Google also doesn't seem to agree 
with you. In other words, it seems to be in pretty limited use.

> An ABI is a definition of an interface, including operations with pre-
> and post-conditions, data structures with their invariants, constants,
> file formats, etc.

Oh, I know what an ABI is. I just don't think your "contract" part has 
anything to do with it. 

> Most of that is covered by the software engineering term `contract'.

I think you're making that up. Maybe there's some sw cult that swears by 
"contract programming", the same way there are the "extreme programming" 
cults etc.  For example, I find this "Design by Contract" cult for object- 
oriented programming, but it has _zero_ to do with external API's, and is 
all about the interfaces for object-oriented components.

IOW, I don't find your arguments or your language usage in the least 
convincing. But hey, I did all my CS stuff outside of the US, whatever.

		Linus
