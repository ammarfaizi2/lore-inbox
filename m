Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbTLJSW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 13:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTLJSW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 13:22:27 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:33291
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S263840AbTLJSWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 13:22:20 -0500
Date: Wed, 10 Dec 2003 10:16:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
Message-ID: <Pine.LNX.4.10.10312101011530.3805-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Thanks for the clarification !

So as I suspected and validated via other means, the content of the
headers are not an issue as it relates to GPL as many claim.

Well I have gotten side requests that I was late in joining the thread
party and I am distracting you from patch merging.  This is a fair point,
and we can restart after 2.6.0 is out.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

On Wed, 10 Dec 2003, Linus Torvalds wrote:

> 
> 
> On Wed, 10 Dec 2003, Andre Hedrick wrote:
> >
> > So why not do the removal of the inlines to real .c files and quit playing
> > games with bogus attempts to bleed taint into the inprotectable api?
> 
> The inlines have nothing to do with _anything_.
> 
> Trust me, a federal judge couldn't care less about some very esoteric
> technical detail. I don't know who brought up inline functions, but they
> aren't what would force the GPL.
> 
> What has meaning for "derived work" is whether it stands on its own or
> not, and how tightly integrated it is. If something works with just one
> particular version of the kernel - or depends on things like whether the
> kernel was compiled with certain options etc - then it pretty clearly is
> very tightly integrated.
> 
> Don't think that copyright would depend on any technicalities.
> 
> 		Linus
> 

