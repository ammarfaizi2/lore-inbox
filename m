Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWCRQM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWCRQM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 11:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbWCRQM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 11:12:29 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:60574 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751415AbWCRQM2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 11:12:28 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=F70kvDR2buohvdbkUzFtYKVz2MtkG3xzXdtDDOYJ/Yn4GJoijlWL6YJunZ1U1AIMeoBAq5IuvsCpEZ6T+m8FhWZvgtJ+Me7K4/Fv+CaPPQppZ+I8O6I77UpIHp/CbjzgTp95oVnDIpKD0I33S9ZyNcM1FC288OZOL1JBbg6pBnE=
Message-ID: <9a8748490603180812n1fda55bfq8909e118cc6dc3cc@mail.gmail.com>
Date: Sat, 18 Mar 2006 17:12:25 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Benjamin Bach" <benjamin@overtag.dk>
Subject: Re: Idea: Automatic binary driver compiling system
Cc: "Arjan van de Ven" <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <441C2CF6.1050607@overtag.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <441AF93C.6040407@overtag.dk> <1142620509.25258.53.camel@mindpipe>
	 <441C213A.3000404@overtag.dk>
	 <1142694655.2889.22.camel@laptopd505.fenrus.org>
	 <441C2CF6.1050607@overtag.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/06, Benjamin Bach <benjamin@overtag.dk> wrote:
> Arjan van de Ven wrote:
> > there are over a thousand open source drivers, and at most a handful
> > binary ones. Please go do your math.
> >
> You're doing the wrong comparison. How many drivers are missing or
> lacking in ability? And if you add to your handful of binary drivers
> those thousands that exist for xp...
> well, numbers do change. Also, most open source drivers aren't made by
> the vendors themselves.
>
> We're doing subjective math here. It doesn't change the fact that Linux
> would be better off with improved hardware support, right?
>

I strongly disagree.

Linux will be better off with improved hardware support by Open Source
drivers - yes.

With improved hardware support by closed source, binary only drivers,
Linux could very well end up being a *lot* worse off.

Once companies have the abillity to easily create closed drivers it
seems very likely that more of them will start withholding specs,
making it impossible to create open drivers.
This in turn will lead to less and less hardware supported by open
drivers. The result of this will be more and more useless bugreports
on LKML making it increasingly hard to maintain and improve the
kernel.  Users will report a bug that may or may not be in an open
part of the kernel, but it will be impossible to tell due to all the
binary only drivers for the users hardware she has loaded.
Binary drivers also put the stability and security of the users system
at the mercy of a commercial entity outside the users control.  A
binary blob loaded into the kernel could do *anything* to compromise
the system or cause it to become unstable and noone would be able to
tell if it's the driver or something else - Linux stability will
suffer and users will in many cases blame Linux, not the driver
vendors.

There's also the issue of companies going out of business, taking
their closed drivers with them. Now the hardware that used to be
supported by Linux is no longer useful since noone can keep the driver
updated.  One could then opt to keep the binary interfaces static to
keep old vendor drivers working, but then we'd quickly accumulate a
bunch of backwards compatibility cruft that would bloat the kernel and
turn it into an unmaintainable mess.

For users there will be a short term bennefit of having more new and
shiny toys work on Linux, but in the longer term it could easily
destroy the usefulness of Linux as a free Operating System.

So please, let's *not* do work to make binary only closed source
drivers easier to make or maintain, it's counterproductive in the long
run.


It's a lot like peeing in your pants to try and stay warm in a
blizzard. It may feel nice initially, but a little later on when your
legs freeze up you'll be a lot worse off than you were initially.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
