Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267607AbUBTAlq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267591AbUBTAlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:41:46 -0500
Received: from citi-181.Connectathon.ORG ([130.128.53.181]:25348 "EHLO
	nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S267703AbUBTAam convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:30:42 -0500
Subject: Re: Eureka! (was Re: UTF-8 and case-insensitivity)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
References: <Pine.LNX.4.58.0402190759550.1222@ppc970.osdl.org>
	 <20040219163838.GC2308@mail.shareable.org>
	 <Pine.LNX.4.58.0402190853500.1222@ppc970.osdl.org>
	 <20040219182948.GA3414@mail.shareable.org>
	 <Pine.LNX.4.58.0402191124080.1270@ppc970.osdl.org>
	 <20040219200554.GE31035@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0402191217050.1439@ppc970.osdl.org>
	 <Pine.LNX.4.58.0402191226240.1439@ppc970.osdl.org>
	 <20040219204853.GA4619@mail.shareable.org>
	 <Pine.LNX.4.58.0402191326490.1439@ppc970.osdl.org>
	 <20040220000054.GA5590@mail.shareable.org>
	 <Pine.LNX.4.58.0402191607490.2244@ppc970.osdl.org>
	 <Pine.LNX.4.58.0402191621250.2244@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077237038.3915.31.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 16:30:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 19/02/2004 klokka 16:24, skreiv Linus Torvalds:
> That said, who actually _uses_ dnotify? The only time dnotify seems to 
> come up in discussions is when people complain how badly designed it is, 
> and I don't think I've ever heard anybody say that they use it and 
> that they liked it ;)

We use it in the idmapper and RPCSEC_GSS userland daemons in order to
track which NFS clients are up and running (by peeking inside the
rpc_pipefs). Works fine there...

Cheers,
  Trond
