Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267517AbUIAUb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267517AbUIAUb1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267575AbUIAUaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:30:21 -0400
Received: from mail.shareable.org ([81.29.64.88]:3786 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S267822AbUIAU10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:27:26 -0400
Date: Wed, 1 Sep 2004 21:25:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901202549.GF31934@mail.shareable.org>
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <200408261819.59328.vda@port.imtp.ilyichevsk.odessa.ua> <1093789802.27932.41.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093789802.27932.41.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2004-08-26 at 16:19, Denis Vlasenko wrote:
> > > Office suites can store a document with embedded images
> > > and spread sheets "easily" by putting the text, the
> > > images and spread sheets all in different file streams.
> > 
> > Kinda far reaching. It's hard to assess whether that is good or bad idea.
> > Can we start small, like putting metadata (e.g. ACLs) into these streams?
> 
> Openoffice does this in user space and the user space vfs code desktops
> use can handle zips so this "just works" already including over NFS,
> unlike a kernel proposed method.

OpenOffice is very sensible, and I agree that a method of handling
document parts that _requires_ kernel support would be foolish.

However, please see my message "The argument for fs assistance in
handling archives" for how kernel support can improve performance of
programs like OpenOffice on large compound documents, while preserving
the sensible behaviour and remaining portable.

-- Jamie
