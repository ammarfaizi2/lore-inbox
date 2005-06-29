Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVF2Ss6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVF2Ss6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262410AbVF2Ss6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:48:58 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:46277 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262420AbVF2Snx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:43:53 -0400
Subject: Re: [patch 2] mm: speculative get_page
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
In-Reply-To: <20050629163132.GB13336@elf.ucw.cz>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au>
	 <42BF9D86.90204@yahoo.com.au> <42C14662.40809@shadowen.org>
	 <42C14D93.7090303@yahoo.com.au> <1119974566.14830.111.camel@localhost>
	 <20050629163132.GB13336@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 11:43:36 -0700
Message-Id: <1120070616.12143.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-29 at 18:31 +0200, Pavel Machek wrote:
> > > I think there are a a few ways that bits can be reclaimed if we
> > > start digging. swsusp uses 2 which seems excessive though may be
> > > fully justified. 
> > 
> > They (swsusp) actually don't need the bits at all until suspend-time, at
> > all.  Somebody coded up a "dynamic page flags" patch that let them kill
> > the page->flags use, but it didn't really go anywhere.  Might be nice if
> > someone dug it up.  I probably have a copy somewhere.
> 
> Unfortunately that patch was rather ugly :-(.

Do you think the idea was ugly, or just the implementation?  Is there
something that you'd rather see?

-- Dave

