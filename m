Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030996AbWKOVE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030996AbWKOVE6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 16:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030733AbWKOVE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 16:04:58 -0500
Received: from nz-out-0102.google.com ([64.233.162.198]:47502 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030996AbWKOVE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 16:04:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y4PGIhajaHVSSHgioJOZvdYEzHYPgg+iPGzGzFcV+FYHg+C34DICfoiCaVFgtpDcKAdsnj08ymhI8RbNtbQcl4jO37WVuga2wQYTCKmErHXjsolObPfV2zl5L7H5a4WrwAkCWEFOLYmDz1mtf65B+fRhN5u5/uhYL+2wp/uEdDw=
Message-ID: <9a8748490611151304i699621a1ub0b432a188c969a3@mail.gmail.com>
Date: Wed, 15 Nov 2006 22:04:56 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
In-Reply-To: <200611101548.kAAFm4EN004162@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <jesper.juhl@gmail.com>
	 <9a8748490611081440u6ba6c541h1038ac1e530e2839@mail.gmail.com>
	 <200611101548.kAAFm4EN004162@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/06, Horst H. von Brand <vonbrand@inf.utfsm.cl> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 08/11/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > > There's no shortage of issues that need fixing, but since we keep
> > > > merging new stuff, a lot of bugfixing energy gets spend on the new
> > > > cool stuff instead of fixing up any other issues we have.
> > >
> > > but if you do this you just end up with a bigger backlog so that the
> > > next one will even be more unstable due to a extreme high change rate.
>
> > Only if people continue to work on new stuff during the "bug fixing only"
> > cycle.  If we manage to get everyone focused on bug fixing only for the
> > entire cycle the backlog won't be growing (much).
>
> Sorry, won't work. People working on shiny new toys will just put off
> sending in their patches for a cycle, and the usual bugfixers will likewise
> just go on doing their stuff.
>
> > > > Coverity has, as of this writing, identified 728 issues in the current
> > > > kernel. Sure, some of those have already been identified as false or
> > > > ignorable issues, but many are flagged as actual bugs and still more
> > > > are as yet uninspected.
>
> > > most are mostly false. And the rest is getting looked at. What's the
> > > problem?
>
> > Yes, MANY are false, and I know the rest are getting worked at, I work on
> > some myself when time permits.  I mentioned it simply as an indicator
> > (one amongst many) that we have a lot of known unfixed issues.
>
> OK, lead by example: Do put off new work and work just on fixing things for
> a while. Collect bug reports and make them useful for would-be-fixers. Etc.

I try. Unfortunately I don't have nearly as much time as I would like,
to work on the kernel, but when I do have time I try to fix bugs. If
you look through the mailing list archives you will see that I try to
fix bugs/buglets most of the time and I find these by combing through
the coverity database, bugzilla, the mailing list, logs of test builds
of new kernels etc etc...
I don't maintain lists of unfixed bugs. I would love to do so, but I
lack the time to do it properly.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
