Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287657AbSAXMWp>; Thu, 24 Jan 2002 07:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287676AbSAXMW2>; Thu, 24 Jan 2002 07:22:28 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:56331 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287657AbSAXMVT>;
	Thu, 24 Jan 2002 07:21:19 -0500
Date: Thu, 24 Jan 2002 10:21:04 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <info@global-digicom.com>, <linux-kernel@vger.kernel.org>
Subject: Re: White Paper on the Linux kernel VM?
In-Reply-To: <200201241206.g0OC66E10502@Port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Pine.LNX.4.33L.0201241017430.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Denis Vlasenko wrote:
> On 24 January 2002 01:36, info@global-digicom.com wrote:
> > I am interested in reviewing the technical specifications on the Linux
> > kernel VM. As there has been much controversy of late on this subject, it

> It was said that code is sufficient, you can read it and ask questions
> on lkml if you will find difficult to swallow parts. You may spot some
> bugs also, that will be very good! Linux kernel needs peer review!

I don't agree with this.  If you don't have documentation, you
only know what the code does, not what it's supposed to do.

This means not only does it become harder to understand things,
it also becomes much harder to verify that the code is doing
the right thing.

> Writing docs wastes developer's time: they will write how they want VM to
> operate or how they think it operates (while some bug can make actual VM
> operate differently) instead of improving/debugging current VM code.

On the contrary.  I have found that updating the documentation
of a function before fixing the code helps to keep me focussed
on letting this function do the exact right thing.

Working the other way around often leads to the "wait a moment,
shouldn't I catch this special case ??" thing and at times to
spagetti code.

Writing the documentation first makes it easier to realise that
some functionality doesn't belong in a function and needs to be
abstracted out, which I'm doing at a nice rate in the -rmap VM.

> Yes, it is not an easy path to VM doc. :-)

Just download the -rmap patch and start reading.
It's not _that_ hard ;)

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

