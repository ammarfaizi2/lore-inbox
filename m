Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263764AbTEGO7a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTEGO7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:59:30 -0400
Received: from havoc.daloft.com ([64.213.145.173]:30111 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263764AbTEGO73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:59:29 -0400
Date: Wed, 7 May 2003 11:12:03 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@ucw.cz>,
       Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: ioctl cleanups: enable sg_io and serial stuff to be shared
Message-ID: <20030507151203.GC3583@gtf.org>
References: <20030507104008$12ba@gated-at.bofh.it> <200305071154.h47BsbsD027038@post.webmailer.de> <20030507124113.GA412@elf.ucw.cz> <20030507135600.A22642@infradead.org> <1052318339.9817.8.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052318339.9817.8.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 07:39:00AM -0700, David S. Miller wrote:
> On Wed, 2003-05-07 at 05:56, Christoph Hellwig wrote:
> > Btw, if you really want to move all the 32bit ioctl compat code to the
> > drivers a ->ioctl32 file operation might be the better choice..
> 
> I can't believe I never thought of that. :-)

Likewise.  That's a good idea...

	Jeff



