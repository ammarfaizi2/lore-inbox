Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVAOB41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVAOB41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAOBsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:48:30 -0500
Received: from [81.2.110.250] ([81.2.110.250]:58345 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262137AbVAOBpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:45:14 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
References: <200501141239.j0ECdaRj005677@laptop11.inf.utfsm.cl>
	 <Pine.LNX.4.58.0501140731450.2310@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105745175.9222.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 15:45, Linus Torvalds wrote:
> On Fri, 14 Jan 2005, Horst von Brand wrote:
> > 
> > But you can trivially run an executable via e.g.:
> > 
> >     /lib/ld-2.3.4.so some-nice-proggie
> 
> I thought we fixed this, and modern ld-so's will fail on this if 
> "some-nice-proggie" cannot be mapped executably. Which is exactly what 
> we'd do.

And I can still write it in perl forget MAP_EXEC and work on almost ever
processor in use today because NX is very recent. Rewriting qemu in perl
might be a bit extreme but its possible 8)

