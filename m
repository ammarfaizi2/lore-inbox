Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVIWUGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVIWUGb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 16:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVIWUGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 16:06:31 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:2158 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750831AbVIWUGa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 16:06:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IyXnkHxiN18+7WrwWB7dl5PU8yOdN6+mcfYywC09KurUORMR/29LXivFBSKBhy0yJRrfPFsQgWpGTOfCskhFqQkgifjTgSMHIPWuRaDXYem3SqYJvi3TkhhsnUlwQRXaZmmD928T+OQoOC+NSLkqNmQ2we0gY9WgWo1S2/ysTzU=
Message-ID: <9a874849050923130623ef40f9@mail.gmail.com>
Date: Fri, 23 Sep 2005 22:06:27 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Hang during rm on ext2 mounted sync (2.6.14-rc2+)
Cc: Andrew Morton <akpm@osdl.org>, Chris Sykes <chris@sigsegv.plus.com>,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
In-Reply-To: <20050923201119.GA9319@mipter.zuzino.mipt.ru>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/05, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Fri, Sep 23, 2005 at 09:45:37PM +0200, Jesper Juhl wrote:
> > On 9/23/05, Andrew Morton <akpm@osdl.org> wrote:
> > > We ought to have the git bisection process documented in the kernel tree,
> > > but we don't, alas.  There's stuff at http://lkml.org/lkml/2005/6/24/234
> > > but a standalone document which walks people through installing git,
> > > pulling the initial tree, building and bisecting is needed (hint).
> > >
> >
> > If noone else is doing this then I'll write such a document.
> > If someone has already started writing it, then please let me know so
> > we don't duplicate work. I'll get write it during the weekend if I
> > hear nothing.
>
> Bisecting itself is described at Documentation/git-bisect.txt:
>
> http://kernel.org/git/?p=git/git.git;a=blob;h=b124b0751c195db82a49d0bcf434da429ec71019;hb=7fe2fc79358673a909d71e62d3f80ffe0f525fce;f=Documentation/git-bisect.txt
>

Thanks, had not seen that document.

So, should I just add to that a section on how to get and install git
and pull the tree, or put that in a new document and just refer to
that document at the top of git-bisect.txt ?
Any preferences?

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
