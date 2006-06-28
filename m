Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWF1Qdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWF1Qdf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 12:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWF1Qde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 12:33:34 -0400
Received: from xenotime.net ([66.160.160.81]:40656 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751413AbWF1Qdd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 12:33:33 -0400
Date: Wed, 28 Jun 2006 09:36:19 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Petr Tesarik <ptesarik@suse.cz>
Cc: info@kernel-api.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
Message-Id: <20060628093619.6b9f2b8c.rdunlap@xenotime.net>
In-Reply-To: <1151511215.8127.74.camel@elijah.suse.cz>
References: <44A1858B.9080102@kernel-api.org>
	<1151495225.8127.68.camel@elijah.suse.cz>
	<44A2749D.7030705@kernel-api.org>
	<20060628090950.c1862a9e.rdunlap@xenotime.net>
	<1151511215.8127.74.camel@elijah.suse.cz>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 18:13:35 +0200 Petr Tesarik wrote:

> On Wed, 2006-06-28 at 09:09 -0700, Randy.Dunlap wrote:
> > On Wed, 28 Jun 2006 14:22:53 +0200 Lukas Jelinek wrote:
> > 
> > > > I looked at
> > > > http://www.kernel-api.org/docs/online/2.6.17/da/dab/structsk__buff.html
> > > > 
> > > > and you apparently ignore kernel-doc for structs. Cf.
> > > > include/linux/skbuff.h:177 ff.
> > > 
> > > There are several problems. The one you describe is probably caused by a
> > > blank line between the struct and the related comment. Doxygen doesn't
> > > recognize it correctly (and simply ignores the comment).
> > 
> > No blank line in this case.
> 
> Oh, yes, there is a blank line between the comment and the struct. It's
> a pitty that someone put much effort into writing a usable description,
> which is then not seen. Anyway, should we find all such occurences in
> the kernel tree and fix them, or make a workaround for doxygen?

Which struct are we talking about here?  I missed it.

I guess the easy answer is Both.
However, I'm working on fixing up the kernel tree, so sending
patches is correct IMO.

---
~Randy
