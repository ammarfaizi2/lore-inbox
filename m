Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268153AbUHFQDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268153AbUHFQDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 12:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268172AbUHFQB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 12:01:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60594 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268173AbUHFP7q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 11:59:46 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC] initialize all arches mem_map in one place
Date: Fri, 6 Aug 2004 08:57:18 -0700
User-Agent: KMail/1.6.2
Cc: linux-mm <linux-mm@kvack.org>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1091779673.6496.1021.camel@nighthawk>
In-Reply-To: <1091779673.6496.1021.camel@nighthawk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408060857.18641.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 6, 2004 1:07 am, Dave Hansen wrote:
> The following patch does what my first one did (don't pass mem_map into
> the init functions), incorporates Jesse Barnes' ia64 fixes on top of
> that, and gets rid of all but one of the global mem_map initializations
> (parisc is weird).  It also magically removes more code than it adds.
> It could be smaller, but I shamelessly added some comments.

Doesn't apply cleanly to the latest BK tree, which patch am I missing?

Thanks,
Jesse
