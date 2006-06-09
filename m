Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030558AbWFIWNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030558AbWFIWNl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030557AbWFIWNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:13:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9161 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030266AbWFIWNj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:13:39 -0400
Date: Fri, 9 Jun 2006 15:15:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sonny Rao <sonny@burdell.org>
Cc: jeff@garzik.org, hch@infradead.org, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC 0/13] extents and 48bit ext3
Message-Id: <20060609151553.30097b44.akpm@osdl.org>
In-Reply-To: <20060609214200.GA18213@kevlar.burdell.org>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>
	<20060609091327.GA3679@infradead.org>
	<20060609030759.48cd17a0.akpm@osdl.org>
	<44899653.1020007@garzik.org>
	<20060609095620.22326f9d.akpm@osdl.org>
	<4489AAD9.80806@garzik.org>
	<20060609103543.52c00c62.akpm@osdl.org>
	<20060609214200.GA18213@kevlar.burdell.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sonny Rao <sonny@burdell.org> wrote:
>
> On Fri, Jun 09, 2006 at 10:35:43AM -0700, Andrew Morton wrote:
> <snip> 
> > All that being said, Linux's filesystems are looking increasingly crufty
> > and we are getting to the time where we would benefit from a greenfield
> > start-a-new-one.  
> 
> I'm curious about this comment; in what way are they _collectively_
> looking crufty ? 

We seem to be lagging behind "the industry" in some areas - handling large
devices, high bandwidth IO, sophisticated on-disk data structures, advanced
manageability, etc.

I mean, although ZFS is a rampant layering violation and we can do a lot of
the things in there (without doing it all in the fs!) I don't think we can
do all of it.

We're continuing to nurse along a few basically-15-year-old filesystems
while we do have the brains, manpower and processes to implement a new,
really great one.

It's just this feeling I have ;)
