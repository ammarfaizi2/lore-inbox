Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbUK3Fbf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbUK3Fbf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 00:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUK3Fbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 00:31:32 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:35297 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261989AbUK3Fb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 00:31:27 -0500
Date: Tue, 30 Nov 2004 06:31:26 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130053126.GA14345@mail.13thfloor.at>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk> <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com> <16810.24893.747522.656073@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <ord5xwvay2.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411290926160.22796@ppc970.osdl.org> <oract0thnj.fsf@livre.redhat.lsd.ic.unicamp.br> <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0411291458040.22796@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2004 at 03:00:17PM -0800, Linus Torvalds wrote:
> 
> 
> On Mon, 29 Nov 2004, Alexandre Oliva wrote:
> > 
> > I don't see it as obvious at all.  The need for an agreement between
> > two parties on an ABI doesn't imply that one party gets to define it
> > and the other gets to follow it. 
> 
> Sorry, but that's not how it works.
> 
> He who writes the code decides what it is. In this case, if the kernel 
> does a new extension, it's the kernel that gets to decide what it is. 
> Full stop.
> 
> If glibc wants to do something new, go wild. The kernel won't care.
> 
> And that's really the fundamental issue. The kernel does not care what
> user land does. The kernel exports functionality, the kernel does _not_
> ask user land to help.

except for the user land kernel helpers ;)
via call_usermodehelper()

> That _does_ make it a one-way street. Sorry.
> 
> 		Linus

sorry too,
Herbert

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
