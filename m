Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUIDWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUIDWdL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 18:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUIDWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 18:33:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:42410 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264113AbUIDWdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 18:33:07 -0400
Date: Sat, 4 Sep 2004 15:29:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: torvalds@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org,
       dcn@sgi.com
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL
 functions.
Message-Id: <20040904152949.5bf7bca8.akpm@osdl.org>
In-Reply-To: <20040904093745.GB5313@devserv.devel.redhat.com>
References: <200409032207.i83M7CKj015068@hera.kernel.org>
	<1094280707.2801.0.camel@laptop.fenrus.com>
	<20040904103529.C13149@infradead.org>
	<20040904093745.GB5313@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> wrote:
>
> On Sat, Sep 04, 2004 at 10:35:29AM +0100, Christoph Hellwig wrote:
> > On Sat, Sep 04, 2004 at 08:51:47AM +0200, Arjan van de Ven wrote:
> > > On Wed, 2004-08-25 at 20:27, Linux Kernel Mailing List wrote:
> > > > ChangeSet 1.1803.128.1, 2004/08/25 18:27:33+00:00, dcn@sgi.com
> > > > 
> > > > 	[IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
> > > > 	
> > > > 	Add wrapper functions for SAL_CALL(), SAL_CALL_NOLOCK(), and
> > > > 	SAL_CALL_REENTRANT() that allow OEM written modules to make
> > > > 	calls to ia64 OEM SAL functions.
> > > > 	
> > > 
> > > are there any such modules? Are they GPL licensed or all proprietary ?
> > 
> > SGI has stated they have propritary modules that need this, that's why it's
> > got added despite my objections.
> 
> if there are no open source modules that use these exports I would like to
> ask these exports to be undone again..

Yes.  Guys, these are the rules we all live by.

Arjan, please submit a patch.
