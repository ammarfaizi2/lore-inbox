Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262416AbVF2Shi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbVF2Shi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 14:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVF2Shi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 14:37:38 -0400
Received: from station-6.events.itd.umich.edu ([141.211.252.135]:8631 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262416AbVF2Sg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 14:36:57 -0400
Date: Wed, 29 Jun 2005 18:31:32 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andy Whitcroft <apw@shadowen.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
Message-ID: <20050629163132.GB13336@elf.ucw.cz>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <42C14662.40809@shadowen.org> <42C14D93.7090303@yahoo.com.au> <1119974566.14830.111.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119974566.14830.111.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I think there are a a few ways that bits can be reclaimed if we
> > start digging. swsusp uses 2 which seems excessive though may be
> > fully justified. 
> 
> They (swsusp) actually don't need the bits at all until suspend-time, at
> all.  Somebody coded up a "dynamic page flags" patch that let them kill
> the page->flags use, but it didn't really go anywhere.  Might be nice if
> someone dug it up.  I probably have a copy somewhere.

Unfortunately that patch was rather ugly :-(.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
