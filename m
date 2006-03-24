Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWCXST6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWCXST6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWCXST6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:19:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34760 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932108AbWCXST4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:19:56 -0500
Date: Fri, 24 Mar 2006 13:19:39 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Stone Wang <pwstone@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through "/proc/meminfo:
 Wired"
In-Reply-To: <442420A2.80807@yahoo.com.au>
Message-ID: <Pine.LNX.4.63.0603241319130.30426@cuia.boston.redhat.com>
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>  <441FEFC7.5030109@yahoo.com.au>
 <bc56f2f0603210733vc3ce132p@mail.gmail.com> <442098B6.5000607@yahoo.com.au>
 <Pine.LNX.4.63.0603241133550.30426@cuia.boston.redhat.com> <442420A2.80807@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2006, Nick Piggin wrote:
> Rik van Riel wrote:
> > On Wed, 22 Mar 2006, Nick Piggin wrote:
> > 
> > > Why would you want to ever do something like that though? I don't think
> > > you should use this name "just in case", unless you have some really good
> > > potential usage in mind.
> > 
> > ramfs
> 
> Why would ramfs want its pages in this wired list? (I'm not so
> familiar with it but I can't think of a reason).

Because ramfs pages cannot be paged out, which makes them locked
into memory the same way mlocked pages are.

-- 
All Rights Reversed
