Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbVIWUvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbVIWUvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264AbVIWUvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:51:17 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:29941 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751263AbVIWUvQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:51:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s4RcFaRRTLfkz2N8A0UiUswDGtCPM43CC70HESPmV2cia34LxqQnm9+2r5zjqFdkfjMzRTFxqlYltPXQE00CLoegDu3QzPxSWxP6JLHbzL2d//tOyKKvHvw1pl8bmGopw1ug1bY7OQjY5sRtBt9/WVZjgKHPY4u5mDgkJDr58Dw=
Message-ID: <9a87484905092313513bdd16d3@mail.gmail.com>
Date: Fri, 23 Sep 2005 22:51:16 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Cc: adobriyan@gmail.com, chris@sigsegv.plus.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
In-Reply-To: <20050923132308.7660e873.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050922163708.GF5898@sigsegv.plus.com>
	 <20050923015719.5eb765a4.akpm@osdl.org>
	 <20050923121932.GA5395@sigsegv.plus.com>
	 <20050923132216.GA5784@sigsegv.plus.com>
	 <20050923121811.2ef1f0be.akpm@osdl.org>
	 <9a8748490509231245d26d875@mail.gmail.com>
	 <20050923201119.GA9319@mipter.zuzino.mipt.ru>
	 <9a874849050923130623ef40f9@mail.gmail.com>
	 <20050923132308.7660e873.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > On 9/23/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > > On Fri, Sep 23, 2005 at 09:45:37PM +0200, Jesper Juhl wrote:
> > > > On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
> > > > > We ought to have the git bisection process documented in the kernel tree,
> > > > > but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
> > > > > but a standalone document which walks people through installing git,
> > > > > pulling the initial tree, building and bisecting is needed (hint).
> > > > >
> > > >
> > > > If noone else is doing this then I'll write such a document.
> > > > If someone has already started writing it, then please let me know so
> > > > we don't duplicate work. I'll get write it during the weekend if I
> > > > hear nothing.
> > >
> > > Bisecting itself is described at Documentation/git-bisect.txt:
> > >
> > > http://kernel.org/git/?p=git/git.git;a=blob;h=b124b0751c195db82a49d0bcf434da429ec71019;hb=7fe2fc79358673a909d71e62d3f80ffe0f525fce;f=Documentation/git-bisect.txt
> > >
> >
> > Thanks, had not seen that document.
> >
> > So, should I just add to that a section on how to get and install git
> > and pull the tree, or put that in a new document and just refer to
> > that document at the top of git-bisect.txt ?
> > Any preferences?
>
> A new document, I think.  People seem to go nuts over this sort of thing
> and write a whole encyclopedia.  I think we'd be better off with just a
> recipe:
>
[snip]
>
> The shorter the better, with exact example commands.
>

Understood. Will do.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
