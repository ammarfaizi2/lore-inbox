Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269849AbUIDJff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269849AbUIDJff (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 05:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269852AbUIDJff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 05:35:35 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:61445 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S269849AbUIDJfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 05:35:31 -0400
Date: Sat, 4 Sep 2004 10:35:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dcn@sgi.com
Subject: Re: [IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
Message-ID: <20040904103529.C13149@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	dcn@sgi.com
References: <200409032207.i83M7CKj015068@hera.kernel.org> <1094280707.2801.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1094280707.2801.0.camel@laptop.fenrus.com>; from arjanv@redhat.com on Sat, Sep 04, 2004 at 08:51:47AM +0200
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 04, 2004 at 08:51:47AM +0200, Arjan van de Ven wrote:
> On Wed, 2004-08-25 at 20:27, Linux Kernel Mailing List wrote:
> > ChangeSet 1.1803.128.1, 2004/08/25 18:27:33+00:00, dcn@sgi.com
> > 
> > 	[IA64] allow OEM written modules to make calls to ia64 OEM SAL functions.
> > 	
> > 	Add wrapper functions for SAL_CALL(), SAL_CALL_NOLOCK(), and
> > 	SAL_CALL_REENTRANT() that allow OEM written modules to make
> > 	calls to ia64 OEM SAL functions.
> > 	
> 
> are there any such modules? Are they GPL licensed or all proprietary ?

SGI has stated they have propritary modules that need this, that's why it's
got added despite my objections.

