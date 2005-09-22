Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVIVGdk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVIVGdk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 02:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750932AbVIVGdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 02:33:40 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:19193 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750949AbVIVGdj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 02:33:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aOgxEsvbxSUJPLc4CQjhuyFK+tdj4TDe5faB0dY+2zUOkj9HAMm6x7NXiox05UssqPCiq9UDB7AwHDpSy8ABsOk2e5703o2IFExQ3u9Tg7Q8zCdPRY52dMYVVcVQKtGfWxApy/uliX1VJ7CDjNiJUmJ41VV54O2rfw2MFCwT6CM=
Message-ID: <9a8748490509212333197a4980@mail.gmail.com>
Date: Thu, 22 Sep 2005 08:33:39 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: abonilla@linuxwireless.org
Subject: Re: Patch Question.
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20050921213219.090d63c5.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1127358091.5644.7.camel@localhost.localdomain>
	 <20050921213219.090d63c5.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/05, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 21 Sep 2005 21:01:31 -0600 Alejandro Bonilla Beeche wrote:
>
> > Hi,
> >
> >       I have a couple of questions about sending patches. I did read the
> > SubmittingPatches Doc but don't recall this.
> >
> > Can anyone send a patch to LKML to be applied?
>
> Anyone can send a patch.  Whether it gets applied depends on
> several factors.
>
> > How long does it normally take for a patch to be merged?
>
> Depends on who you ask to merge it.  Andrew put patches into
> the -mm patchset within minutes sometimes, depending on how
> busy he is, what else he is doing, etc.
>
> But it varies quite a bit by driver or subsystem maintainer.
>
Also depends on the content of the patch. If it is tricky to read/non
obvious etc it will usually draw some comments before being merged.
Some patches get missed/overlooked completely - in that case it's up
to you to make sure it gets resend after a while (if it draws no
comments and doesn't get merged, then resending it after the next
majoe, -rc or -mm release, updated to apply to that release, is
usually good).
I've personally sent patches that got merged by someone within a few
minutes, but I've also seen patches suddenly get merged that I had
completely forgotten about that some maintainer just picked up from
the list weeks after I had sent it.


> > If a patch is not merged and I get no Replys, what should one do?
>
> Send it to the correct maintainer (driver or subsystem usually).
> If you can't find a correct maintainer, then send it to Andrew
> (akpm@osdl.org).  Maybe put "[RFC]" in the Subject: line to
> get (more) comments on it.
>
Resend the patch and check your To: and Cc: lists. Read the
MAINTAINERS file to find out who to send it to, as well as comments in
the top of the source file. Adding linux-kernel@vger.kernel.org to Cc:
in any case, in addition to other recipients, is usually a good thing
as well.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
