Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261921AbSJQS7F>; Thu, 17 Oct 2002 14:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262060AbSJQS7F>; Thu, 17 Oct 2002 14:59:05 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:44029 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261921AbSJQS7D>;
	Thu, 17 Oct 2002 14:59:03 -0400
Date: Thu, 17 Oct 2002 15:05:00 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Greg KH <greg@kroah.com>
cc: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
In-Reply-To: <20021017185352.GA32537@kroah.com>
Message-ID: <Pine.GSO.4.21.0210171459420.17992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 17 Oct 2002, Greg KH wrote:

> Yes, it's a big switch, but what do you propose otherwise?  SELinux
> would need a _lot_ of different security calls, which would be fine, but

... or somebody willing to <gasp> try and come up with decent API.
Had you reviewed their extra syscalls, BTW?  Do it - and remove
sharp objects before that...

> we don't want to force every security module to try to go through the
> process of getting their own syscalls.

... or, heaven forbid, actually designing interfaces instead of putting
together piles of kludges.  Can't have it...

> And other subsystems in the kernel do the same thing with their syscall,
> like networking, so there is a past history of this usage.

Overloadable by arbitrary protocol family driver?  Where?

