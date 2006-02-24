Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbWBXNfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbWBXNfP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBXNfP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:35:15 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:25848 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750807AbWBXNfO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:35:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GNMQGeiDuh0q1HQE4SEyR24x7tOz62kfp9nfIlNtiMivKjEoMGXUK14APSPtJrrcNLT/1QAJ2eu9fzwMjWqWA0vuyiuVFI87YCNm0f2aifY19zl2AdxHkupVzpbgtZ5dXCEZq7xRFhgXkxiIrrWHmVeTSOl7nYviXvEuoJPlx9Y=
Message-ID: <9a8748490602240535r5c956e76o6226e4bc8337f9dd@mail.gmail.com>
Date: Fri, 24 Feb 2006 14:35:12 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andres Salomon" <dilinger@debian.org>
Subject: Re: [PATCH] x86_64 stack trace cleanup
Cc: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1140780552.5073.26.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1140777679.5073.17.camel@localhost.localdomain>
	 <200602241147.03041.ak@suse.de>
	 <1140780552.5073.26.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/24/06, Andres Salomon <dilinger@debian.org> wrote:
> On Fri, 2006-02-24 at 11:47 +0100, Andi Kleen wrote:
[snip]
>
> > The problem is your new format uses more screen estate, which is precious
> > after an oops because the VGA scrollback is so small.
> > That is why i rejected the earlier attempts at changing this.
> >
>
> I don't see why this is a problem.  Other architectures have done this
> for ages, without problems.  I suspect most people get their backtraces
> from either serial console or logs, as copying them down from the screen
> or taking a picture of the panic is a rather large pain.  It seems like
> you're penalizing everyone for a few select use cases.
>

Some of us don't have a digital camera for taking a picture (and
besides, being able to take a picture doesn't fix the problem of oops
output scrolling out of the visible screen area).
Some of us also don't have a second PC on which to capture logs via
netconsole or serial console.
Copying oopses down by hand from screen to paper sure is a pain (I
know, I've had to do it quite a few times), but for some it's the only
option and then we generally want as much info as possible on-screen
to copy down.

And btw, multi-column oops output has recently become an option for
i386 as well - in my oppinion a good thing.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
