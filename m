Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932602AbWAECic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932602AbWAECic (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 21:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932963AbWAECib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 21:38:31 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30510 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932989AbWAECiM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 21:38:12 -0500
Date: Wed, 04 Jan 2006 21:38:09 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [patch 00/21] mutex subsystem, -V14
In-reply-to: <43BC5E15.207@austin.ibm.com>
X-X-Sender: nico@localhost.localdomain
To: Joel Schopp <jschopp@austin.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>, Al Viro <viro@ftp.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Anton Blanchard <anton@samba.org>
Message-id: <Pine.LNX.4.64.0601042133230.27409@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <20060104144151.GA27646@elte.hu> <43BC5E15.207@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2006, Joel Schopp wrote:

> > this is version 14 of the generic mutex subsystem, against v2.6.15.
> > 
> > The patch-queue consists of 21 patches, which can also be downloaded from:
> > 
> >   http://redhat.com/~mingo/generic-mutex-subsystem/
> > 
> 
> Took a glance at this on ppc64.  Would it be useful if I contributed an arch
> specific version like arm has?  We'll either need an arch specific version or
> have the generic changed.

Don't change the generic version.  You should provide a ppc specific 
version if the generic ones don't look so good.


Nicolas
