Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262422AbUK3XJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbUK3XJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 18:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262443AbUK3XGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 18:06:12 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53413 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262426AbUK3XDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 18:03:31 -0500
Date: Tue, 30 Nov 2004 23:03:25 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Mariusz Mazur <mmazur@kernel.pl>
Cc: Sam Ravnborg <sam@ravnborg.org>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Alexandre Oliva <aoliva@redhat.com>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, Matthew Wilcox <matthew@wil.cx>,
       David Howells <dhowells@redhat.com>, hch@infradead.org,
       linux-kernel@vger.kernel.org, libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041130230325.GY26051@parcelfarce.linux.theplanet.co.uk>
References: <19865.1101395592@redhat.com> <Pine.LNX.4.58.0411301243000.22796@ppc970.osdl.org> <20041130223359.GA15443@mars.ravnborg.org> <200411302344.21907.mmazur@kernel.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411302344.21907.mmazur@kernel.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 11:44:21PM +0100, Mariusz Mazur wrote:
> On wtorek 30 listopad 2004 23:33, Sam Ravnborg wrote:
> > On Tue, Nov 30, 2004 at 12:47:50PM -0800, Linus Torvalds wrote:
> >  If that's all that people want, I hereby proclaim that
> >
> > >  include/asm-xxx/user/xxxx.h
> > >  include/user/xxxx.h
> > >
> > > is reserved for user-visible stuff. And now you can send me small and
> > > localized patches that fix a _particular_ gripe.
> >
> > Please use:
> >   include/$arch/user-asm/xxxx.h
> >   include/user/xxxx.h
> 
> Wrong. These dirs must be linked to /usr/include so they must have more 
> meaningfull names.

WTF?  I've got a dozen kernel trees hanging around, which one (and WTF any,
while we are at it) should be "linked to"?
