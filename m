Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbVIFWc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbVIFWc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbVIFWc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 18:32:28 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:19041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVIFWc1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 18:32:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NF40uFbhCI4NUbv/JtABwCO0znLqH5xMNLYKLOsp6JClCEYMOoPija2hMKbikijOidrWnm2pt0rqM+7c+Uj6HVs3uRWVwknr5UO4ewaXQVo09VbJolnnlkhmhcaSFXUvG6Nha7aMBRGilN8gRy2Mm+nqGXrmkmXsMGKdnQniOPc=
Message-ID: <9a8748490509061532235cefa5@mail.gmail.com>
Date: Wed, 7 Sep 2005 00:32:26 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Esben Nielsen <simlo@phys.au.dk>
Subject: Re: kbuild & C++
Cc: "Budde, Marco" <budde@telos.de>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9a87484905090614204ba36b83@mail.gmail.com>
	 <Pine.OSF.4.05.10509070012390.28020-100000@da410.phys.au.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Esben Nielsen <simlo@phys.au.dk> wrote:
> On Tue, 6 Sep 2005, Jesper Juhl wrote:
> 
> > On 9/6/05, Budde, Marco <budde@telos.de> wrote:
> > > Hi,
> > >
> > > for one of our customers I have to port a Windows driver to
> > > Linux. Large parts of the driver's backend code consists of
> > > C++.
> > >
> > > How can I compile this code with kbuild? The C++ support
> > > (I have tested with 2.6.11) of kbuild seems to be incomplete /
> > > not working.
> > >
> >
> > That would be because the kernel is written in *C* (and some asm), *not* C++.
> > There /is/ no C++ support.
> 
> Which is too bad. You can do stuff much more elegant, effectively and
> safer in C++ than in C. Yes, you can do inheritance in C, but it leaves
> it up to the user to make sure the type-casts are done OK every time. You
> can with macros do some dynamic typing, but not nearly as effectively as
> with templates, and those macros always comes very, very ugly. (Some say
> templates are ugly, but they first become ugly when they are used
> way beyond what you can do with macros.)
> 
> I think it can only be a plus to Linux to add C++ support for at least
> out-of-mainline drivers. Adding drivers written in C++ into the mainline
> is another thing.
> 

I was not trying to start a discussion about the merrits of C vs C++.
I was simply responding to marco's comment that "C++ support ... of
kbuild seems to be incomplete / not working".

As for C++ vs C.  I don't have anything against C++. I use it a lot
for userspace programs. I'm not sure I agree that it would be
appropriate for the kernel though, but that's a whole other
discussion.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
