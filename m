Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262062AbVAYS6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262062AbVAYS6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 13:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVAYS6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 13:58:21 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:41907 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262062AbVAYS5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 13:57:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=SjDkiNwmgSTIqkuIQnWuf2qUUZxGXJOmi7k/pCsr5H1bIMh4Hz4lSq0pCeoRuBLv7gW06CV3TdXTS6Y8XEDYfDDj+k7dX10E2kshD1RNNWWgv24gfSezedmMSfW0vqxDi+cPGpzgfy25nCRT39pNYj8eeLXymxTYotBSZ53ykBU=
Message-ID: <d120d50005012510571d77338d@mail.gmail.com>
Date: Tue, 25 Jan 2005 13:57:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: thoughts on kernel security issues
Cc: Linus Torvalds <torvalds@osdl.org>, Bill Davidsen <davidsen@tmr.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41F691D6.8040803@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1106157152.6310.171.camel@laptopd505.fenrus.org>
	 <200501191947.j0JJlf3j024206@turing-police.cc.vt.edu>
	 <41F6604B.4090905@tmr.com>
	 <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org>
	 <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net>
	 <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org>
	 <41F691D6.8040803@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2005 13:37:10 -0500, John Richard Moser
<nigelenki@comcast.net> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Linus Torvalds wrote:
> >
> > On Tue, 25 Jan 2005, John Richard Moser wrote:
> >
> >>It's kind of like locking your front door, or your back door.  If one is
> >>locked and the other other is still wide open, then you might as well
> >>not even have doors.  If you lock both, then you (finally) create a
> >>problem for an intruder.
> >>
> >>That is to say, patch A will apply and work without B; patch B will
> >>apply and work without patch A; but there's no real gain from using
> >>either without the other.
> >
> >
> > Sure there is. There's the gain that if you lock the front door but not
> > the back door, somebody who goes door-to-door, opportunistically knocking
> > on them and testing them, _will_ be discouraged by locking the front door.
> >
> 
> In the real world yes.  On the computer, the front and back doors are
> half-consumed by a short-path wormhole that places them right next to
> eachother, so not really.  :)
> 

Then one might argue that doing any security patches is meaningless
because, as with bugs, there will always be some other hole not
covered by both A and B so why bother?

-- 
Dmitry
