Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUHFRGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUHFRGT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHFRC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:02:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:65479 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268198AbUHFQ4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 12:56:12 -0400
Subject: Re: [RFC] initialize all arches mem_map in one place
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: linux-mm <linux-mm@kvack.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200408060857.18641.jbarnes@engr.sgi.com>
References: <1091779673.6496.1021.camel@nighthawk>
	 <200408060857.18641.jbarnes@engr.sgi.com>
Content-Type: text/plain
Message-Id: <1091811353.6496.2608.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 06 Aug 2004 09:55:53 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-06 at 08:57, Jesse Barnes wrote:
> On Friday, August 6, 2004 1:07 am, Dave Hansen wrote:
> > The following patch does what my first one did (don't pass mem_map into
> > the init functions), incorporates Jesse Barnes' ia64 fixes on top of
> > that, and gets rid of all but one of the global mem_map initializations
> > (parisc is weird).  It also magically removes more code than it adds.
> > It could be smaller, but I shamelessly added some comments.
> 
> Doesn't apply cleanly to the latest BK tree, which patch am I missing?

It should only be against the latest mm: 2.6.8-rc3-mm1

-- Dave

