Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267415AbSKQAMQ>; Sat, 16 Nov 2002 19:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267417AbSKQAMP>; Sat, 16 Nov 2002 19:12:15 -0500
Received: from 12-231-236-219.client.attbi.com ([12.231.236.219]:47072 "EHLO
	mystic.osdl.org") by vger.kernel.org with ESMTP id <S267415AbSKQAMO>;
	Sat, 16 Nov 2002 19:12:14 -0500
From: Nathan <smurf@osdl.org>
Date: Sat, 16 Nov 2002 16:18:45 -0800
To: Dan Kegel <dank@kegel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
Message-ID: <20021117001845.GD12011@mystic.osdl.org>
References: <3DD5D93F.8070505@kegel.com> <3DD5DC77.2010406@pobox.com> <20021116151102.GI19015@higherplane.net> <3DD6B2C5.3010303@pobox.com> <20021116213732.GO24641@conectiva.com.br> <20021116214250.GQ24641@conectiva.com.br> <1037490677.24843.7.camel@irongate.swansea.linux.org.uk> <3DD6DE32.60503@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DD6DE32.60503@kegel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 16, 2002 at 04:09:22PM -0800, Dan Kegel wrote:
> * maintainers try to not forward any patches to Linux that
>   cause 'make curyesconfig' or 'make curmodconfig' not build

The PLM is a *really* good way to get that verified for almost No Work.

> * OSDL does nightly 'curyesconfig' and 'curmodconfig builds from
>   Linus's tree, and mails linux-kernel a link to the build log
>   along with whether it succeeded or failed

Automatic emails to LK will become noise and get ignored very quickly.

> That would give maintainers quick feedback about whether they'd
> broken some obscure part of Linus's tree...

Maintainers of the major trees always get quick feedback.  In the form
of "it doesn't compile" and compile patches.  Inserting some proactive
testing into the development process would help more than the feedback.

It would be cool if maintainers would only accept patches that are
verified to compile.

The big problem compile errors causes with the pre* and rc* series
kernels is it vastly reduces the number of potential testers.  Not
because of an inability to apply patches, but because testing has to be
as easy as possible to get a wide audience.  Finding the "bug" of a
compile error is so common now, reporting the bug isn't even interesting
most of the time.  Testers know that chances are someone else has found
it and someone else is probably 75% done with the patch to fix it.

It would be a Good Thing if finding bugs in the kernel releases was
cause for at least a little bit of surprise and interest.

If any tree maintainers are interested in having their trees auto-sucked
into the PLM, please let me know.  I can set it up to email you the
compile results or not.

-Nathan
