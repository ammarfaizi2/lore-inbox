Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbULASID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbULASID (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 13:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261406AbULASID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 13:08:03 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:52885 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261403AbULASH4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 13:07:56 -0500
Date: Wed, 1 Dec 2004 19:08:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041201180819.GA8220@mars.ravnborg.org>
Mail-Followup-To: Mariusz Mazur <mmazur@kernel.pl>,
	Sam Ravnborg <sam@ravnborg.org>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Alexandre Oliva <aoliva@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <19865.1101395592@redhat.com> <200412010008.13572.mmazur@kernel.pl> <20041201052328.GA8157@mars.ravnborg.org> <200412011152.45279.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412011152.45279.mmazur@kernel.pl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2004 at 11:52:45AM +0100, Mariusz Mazur wrote:
> On ?roda 01 grudzie? 2004 06:23, Sam Ravnborg wrote:
> > > Linked, copied, mount --binded, whatever. Just not under the
> > > name /usr/include/user, but something more meaningfull.
> >
> > Whats wrong with
> > /lib/modules/`uname -r`/source/include/user
> > /lib/modules/`uname -r`/source/include/$arch
> 
> Those are supposed to be userland-only headers that don't just change - they 
> are gradually expanded. I don't see a point in having `uname -r` in there.
> 
> And another thing - distribution vendors will *hate* anyone, that encourages 
> app developers to add an include path based on which kernel is being 
> currently run. People, that have their headers tied to their kernels are a 
> *minority*.
Above shows how this minority could locate headers for running kernel.
It is not meant to be the general solution.

	Sam
