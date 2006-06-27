Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751308AbWF0Iu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbWF0Iu2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWF0Iu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 04:50:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28578 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932655AbWF0Iu1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 04:50:27 -0400
Date: Tue, 27 Jun 2006 01:50:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: hch@infradead.org, swhiteho@redhat.com, torvalds@osdl.org,
       teigland@redhat.com, pcaulfie@redhat.com, kanderso@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-Id: <20060627015005.21c20186.akpm@osdl.org>
In-Reply-To: <20060627083544.GA32761@elte.hu>
References: <1150805833.3856.1356.camel@quoit.chygwyn.com>
	<20060623144928.GA32694@infradead.org>
	<20060626200300.GA15424@elte.hu>
	<20060627063339.GA27938@elte.hu>
	<20060627000633.91e06155.akpm@osdl.org>
	<20060627083544.GA32761@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 10:35:44 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Tue, 27 Jun 2006 08:33:39 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > Isnt this whole episode highly hypocritic to begin with?
> > 
> > Might be, but that's not relevant to GFS2's suitability.
> 
> it is relevant to a certain degree, because it creates a (IMO) false 
> impression of merging showstoppers. After months of being in -mm, and 
> after addressing all issues that were raised (and there was a fair 
> amount of review activity December last year iirc), one week prior the 
> close of the merge window a 'huge' list of issues are raised. (after 
> belovingly calling the GFS2 code a "huge mess", to create a positive and 
> productive tone for the review discussion i guess.)

It's a general problem - our reviewing resources do not have the capacity
to cover our coding resources.  This is especially the case on filesystems.
 We'd have merged (a very different) reiser4 a year ago if things were
in balance.

(and our code-breaking resources appear to exceed our code-fixing resources
too, but that's another topic).
