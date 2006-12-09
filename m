Return-Path: <linux-kernel-owner+w=401wt.eu-S1761256AbWLINzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761256AbWLINzr (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 08:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761333AbWLINzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 08:55:47 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:40425 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761256AbWLINzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 08:55:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fkCcar5H55zzFXDrH1bI6yB5dLyZE+2E2o/3QBySnuW5eF0oddwAH2t5Vnc9/Y8YTyhaMxjYR3q+doqFOuXMvhQXCo8NrJDwEXeAU1dhs9VGqzDCjdFIA+PQKU+sfhQnNvQzRXoRd4GTRzFEFmZWKtS/fnXaFQyJL+NCQWPB64M=
Message-ID: <9a8748490612090555q5eb5edfr1a0c20fde2b16ad2@mail.gmail.com>
Date: Sat, 9 Dec 2006 14:55:45 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: why are some of my patches being credited to other "authors"?
Cc: "Tim Schmielau" <tim@physik3.uni-rostock.de>,
       "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       "Linux kernel mailing list" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612090813080.13873@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0612090515480.12992@localhost.localdomain>
	 <1165663793.1103.127.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0612090656140.13654@localhost.localdomain>
	 <Pine.LNX.4.63.0612091327540.24913@gockel.physik3.uni-rostock.de>
	 <Pine.LNX.4.64.0612090813080.13873@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/06, Robert P. J. Day <rpjday@mindspring.com> wrote:
> On Sat, 9 Dec 2006, Tim Schmielau wrote:
>
> > i wrote:
>
> > > but given that i'm trying to follow the kernel guidelines and keep
> > > each submission as a logically-related chunk, in many cases, i
> > > have to wait for one patch to be applied before i can submit the
> > > next one. and, at the moment, there's no way of knowing what's
> > > going on.
> >
> > Well, you can send out a patch series:
> >   [patch 01/02] Prepare foo for blah
> >   [patch 02/02] Apply blah to foo
> > Ideally you would finish the patch description for patch 02 with something
> > like
> >
> > ---
> > This patch depends on [patch 01/02] Prepare foo for blah
>
> ... snip ...
>
> wait a minute.  that's not what i've understood all this time as the
> rationale for a multi-part patch -- to show dependency.  certainly,
> that's not what you read in "SubmittingPatches":
>
> "If one patch depends on another patch in order for a change to be
> complete, that is OK.  Simply note "this patch depends on patch X" in
> your patch description."
>
> that doesn't say anything about using the multi-part notation.  are
> you sure about this?
>
I've done this several times. It's quite a common way of doing it.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
