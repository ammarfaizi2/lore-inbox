Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVF3DNq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVF3DNq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 23:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbVF3DNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 23:13:46 -0400
Received: from mailwasher.lanl.gov ([192.65.95.54]:47198 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262800AbVF3DNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 23:13:44 -0400
Date: Wed, 29 Jun 2005 21:13:38 -0600 (MDT)
From: "Ronald G. Minnich" <rminnich@lanl.gov>
To: Greg KH <greg@kroah.com>
cc: Roland Dreier <rolandd@cisco.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH 05/16] IB uverbs: core implementation
In-Reply-To: <20050629002709.GB17805@kroah.com>
Message-ID: <Pine.LNX.4.58.0506292112380.15717@enigma.lanl.gov>
References: <2005628163.lUk0bfpO8VsSXUh5@cisco.com> <2005628163.jfSiMqRcI78iLMJP@cisco.com>
 <20050629002709.GB17805@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-PMX-Version: 4.7.0.111621
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Jun 2005, Greg KH wrote:

> On Tue, Jun 28, 2005 at 04:03:43PM -0700, Roland Dreier wrote:
> > +++ linux/drivers/infiniband/core/uverbs_main.c	2005-06-28 15:20:04.363963991 -0700
> > @@ -0,0 +1,708 @@
> > +/*
> > + * Copyright (c) 2005 Topspin Communications.  All rights reserved.
> > + * Copyright (c) 2005 Cisco Systems.  All rights reserved.
> > + *
> > + * This software is available to you under a choice of one of two
> > + * licenses.  You may choose to be licensed under the terms of the GNU
> > + * General Public License (GPL) Version 2, available from the file
> > + * COPYING in the main directory of this source tree, or the
> > + * OpenIB.org BSD license below:
> 
> Ok, I've complained about this before, but due to the fact that you are
> calling EXPORT_SYMBOL_GPL() only functions in this code, the ability for
> it for someone to use the BSD license on it in the future, is pretty
> much impossible, right?

This does seem odd. If the goal is kernel inclusion, and the kernel is 
GPL, seems like this license boilerplate should now change. It makes no 
real sense otherwise, as far as I can tell.

ron
