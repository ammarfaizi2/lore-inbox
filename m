Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264041AbTEJL1G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 07:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264043AbTEJL1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 07:27:04 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:22508 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264041AbTEJL0j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 07:26:39 -0400
Date: Sat, 10 May 2003 13:39:10 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
Message-ID: <20030510113910.GD12431@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org> <20030509075319.A10102@infradead.org> <20030510102615.GB12431@louise.pinerecords.com> <20030510113843.GC12431@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030510113843.GC12431@louise.pinerecords.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [szepe@pinerecords.com]
> 
> > [szepe@pinerecords.com]
> > 
> > > [hch@infradead.org]
> > > 
> > > This is the patch I sent marcelo just after rc1 was released, I gues
> > > it will still apply..
> > 
> > Christoph, for a fully modular IDE (.config snippet included at the
> > end of the post) on .21rc2 I need to apply the following patch on top
> > of the one you have posted.  100% untested.
> 
> This is still not enough.  pci-*.o objects will need to be linked
> into a single ide.o module.  I'm leaving that up to somebody else. :)

s/pci-/ide-/ of course.
