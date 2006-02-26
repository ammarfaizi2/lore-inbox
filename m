Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWBZV42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWBZV42 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 16:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWBZV42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 16:56:28 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:18437 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751043AbWBZV41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 16:56:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dG+ybXv0pPRYWQkiGs5nPqNwjR37UsthyvPa1UETMJj1JUxV7wVyEGzZ4y9i3PLVC2er4rofDlBlZqbaBpwjoerAYCwZ/OXb6jjaofN1cBG8lA3lcLscycKOqyXpfn6O+dKkR8tbN0GYAqF9u+gBq0FSmgHMGBgt8HkHBOcHguU=
Message-ID: <9a8748490602261356l222c9689w8fa1d5e2395bb183@mail.gmail.com>
Date: Sun, 26 Feb 2006 22:56:26 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <1140990819.24141.176.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe> <87wtfh3i9z.fsf@hades.wkstn.nix>
	 <9a8748490602261349v381933b9xeb2ddeedac053910@mail.gmail.com>
	 <1140990819.24141.176.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-02-26 at 22:49 +0100, Jesper Juhl wrote:
> > On 2/26/06, Nix <nix@esperi.org.uk> wrote:
> > > (i.e., there's a reason that warning uses the word *might*.)
> > >
> > The compiler says "might be used uninitialized" when it cannot
> > determine if a variable will be initialized before first use or not.
>
> Quoting the "silence gcc warning" thread:
>
> "Really, this is a gcc bug.  My version of the compiler:
>
> gcc version 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)
>
> Doesn't give this warning.  And, since the loop has fixed parameters,
> gcc should see not only that it's always executed, but that it could be
> unrolled."
>
Yeah so gcc is not perfect, but that still doesn't change that the
intention of the warning and the use of the word "might" is as I said
above.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
