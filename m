Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267856AbUIVEja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267856AbUIVEja (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 00:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267864AbUIVEja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 00:39:30 -0400
Received: from ares.cs.Virginia.EDU ([128.143.137.19]:12790 "EHLO
	ares.cs.Virginia.EDU") by vger.kernel.org with ESMTP
	id S267856AbUIVEj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 00:39:28 -0400
Date: Wed, 22 Sep 2004 00:39:22 -0400 (EDT)
From: Ronghua Zhang <rz5b@cs.virginia.edu>
To: Robert Love <rml@novell.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Does ZONE_HIGHMEM exist on machines with 1G memeory
In-Reply-To: <1095826387.2454.101.camel@localhost>
Message-ID: <Pine.GSO.4.51.0409220035500.8395@mamba.cs.Virginia.EDU>
References: <Pine.GSO.4.51.0409212305520.8395@mamba.cs.Virginia.EDU>
 <1095826387.2454.101.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But why cannot we simply map the whole physical memory into the 1GB
kernel virtual address space? In this case, we don't need to reserve any
address space for the permanent or temporary mapping. Am I missing
something here? Thanks

RZ

On Wed, 22 Sep 2004, Robert Love wrote:

> On Tue, 2004-09-21 at 23:09 -0400, Ronghua Zhang wrote:
>
> >   This may be a dumb question. But it seems to me that when the machine
> > has 1GB memory, it can be mapped to the 1GB kernel virtual address space.
> > Do we still need ZONE_HIGHMEM in this case? Please CC any follow-up to me.
> > Thanks
>
> Highmem is actually everything above 896MB ... so, yes, you need
> ZONE_HIGHMEM.
>
> 	Robert Love
>
>
