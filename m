Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTJMIbw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbTJMIbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:31:52 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2688 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261555AbTJMIbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:31:23 -0400
Date: Mon, 13 Oct 2003 09:32:19 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310130832.h9D8WJ4g000157@81-2-122-30.bradfords.org.uk>
To: Andrew Morton <akpm@osdl.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031013011117.103de5e7.akpm@osdl.org>
References: <Pine.LNX.4.53.0310130354440.28426@montezuma.fsmlabs.com>
 <20031013011117.103de5e7.akpm@osdl.org>
Subject: Re: [PATCH][2.6] No swapping on memory backed swapfiles
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Andrew Morton <akpm@osdl.org>:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> >
> > +	bdi = mapping->backing_dev_info;
> >  +	if (bdi->memory_backed)
> >  +		goto bad_swap;
> >  +
> 
> I guess that makes sense, although someone might want to swap onto a
> ramdisk-backed file just for some testing purpose.

Or because some RAM is slower than the rest.  This came up a while ago
on the list.

John.
