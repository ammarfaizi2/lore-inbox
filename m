Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316822AbSGQWHl>; Wed, 17 Jul 2002 18:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316823AbSGQWHl>; Wed, 17 Jul 2002 18:07:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:8687 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316822AbSGQWHk>; Wed, 17 Jul 2002 18:07:40 -0400
Subject: Re: [BK PATCH] agpgart changes for 2.5.26
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Dave Jones <davej@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020717203601.GB10047@kroah.com>
References: <20020717183615.GB9589@kroah.com>
	<20020717213056.I18170@suse.de>  <20020717203601.GB10047@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 00:21:03 +0100
Message-Id: <1026948063.7804.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-07-17 at 21:36, Greg KH wrote:
> On Wed, Jul 17, 2002 at 09:30:56PM +0200, Dave Jones wrote:
> >  >  drivers/char/agp/via.c               |  151 +
> > 
> > Linus last comment mentioned via-agp.c, and the likes,
> > which I did in my tree, but haven't put up a diff yet.
> > I could dig those out for you, but you could probably
> > 'mv' them faster than I can chunk up the diff into pieces.
> 
> But that would make:
> 	drivers/char/agp/via-agp.c
> which is redundant, as that file does not compile to a separate module,
> but gets linked to the larger agpgart.o like before.

Its only redundant until they day AGP does become a set of loadable
modules rather than one. 

