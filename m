Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314077AbSGUMRV>; Sun, 21 Jul 2002 08:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314078AbSGUMRV>; Sun, 21 Jul 2002 08:17:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:24565 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314077AbSGUMRU>; Sun, 21 Jul 2002 08:17:20 -0400
Subject: Re: [PATCH] strict VM overcommit
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Alan Cox <alan@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0207211008280.701-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0207211008280.701-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Jul 2002 14:32:29 +0100
Message-Id: <1027258349.17234.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 10:10, Szakacsits Szabolcs wrote:
> 
> On Fri, 19 Jul 2002, Alan Cox wrote:
> > > How is assured that it's impossible to OOM when the amount of memory
> > > shrinks?
> > > IOW:
> > > - allocate very much memory
> > > - "swapoff -a"
> >
> > Make swapoff -a return -ENOMEM
> >
> > I've not done this on the basis that this is root specific stupidity and
> > generally shouldnt be protected against
> 
> Recommended reading: MIT's Magazin of Innovation Technology Review,
> August 2002 issue, cover story: Why Software Is So Bad?
> 
> Next you might read: "... prominent, leading Linux kernel developer
> publically labels users stupid instead of handling a special case

I would suggest you do something quite different. Go and read what K&R
had to say about the design of Unix. One of the design goals of Unix is
that the system does not think it knows better than the administrator.
That is one of the reasons unix works well and is so flexible.

Alan

