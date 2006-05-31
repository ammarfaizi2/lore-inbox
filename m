Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWEaCig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWEaCig (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 22:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWEaCig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 22:38:36 -0400
Received: from rune.pobox.com ([208.210.124.79]:43937 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1751185AbWEaCif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 22:38:35 -0400
Date: Tue, 30 May 2006 19:38:24 -0700
From: Paul Dickson <paul@permanentmail.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: lkml@rtr.ca, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: Resume stops working between 2.6.16 and 2.6.17-rc1 on Dell
 Inspiron 6000
Message-Id: <20060530193824.5eec92f7.paul@permanentmail.com>
In-Reply-To: <20060529151216.GB4356@ucw.cz>
References: <20060528140238.2c25a805.dickson@permanentmail.com>
	<1148850683.3074.72.camel@laptopd505.fenrus.org>
	<20060528142951.2a7417cb.dickson@permanentmail.com>
	<447A1AEF.3040900@rtr.ca>
	<20060528172101.a1b9725e.dickson@permanentmail.com>
	<447A642F.6080500@rtr.ca>
	<20060529151216.GB4356@ucw.cz>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006 15:12:16 +0000, Pavel Machek wrote:

> 
> Hi!
> 
> > >I still get the BUG message on resuming that I reported 
> > >in bugzilla
> > ...
> > >BUG: sleeping function called from invalid context at 
> > >mm/slab.c:2794
> > >in_atomic():0, irqs_disabled():1

> > 
> > Yup, pretty obvious bug in the acpi code.
> > Something probably needs to use GFP_ATOMIC there.
> 
> Does it still happen in -rc5?

Yes.  That was the kernel that the dmesg came from.

	-Paul

