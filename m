Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVC1VXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVC1VXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 16:23:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262076AbVC1VXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 16:23:34 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:424 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261942AbVC1VXc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 16:23:32 -0500
Subject: Re: [PATCH 0/4] sparsemem intro patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050319193345.GE1504@openzaurus.ucw.cz>
References: <1110834883.19340.47.camel@localhost>
	 <20050319193345.GE1504@openzaurus.ucw.cz>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 13:23:25 -0800
Message-Id: <1112045005.2087.38.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-19 at 20:33 +0100, Pavel Machek wrote:
> > Three of these are i386-only, but one of them reorganizes the macros
> > used to manage the space in page->flags, and will affect all platforms.
> > There are analogous patches to the i386 ones for ppc64, ia64, and
> > x86_64, but those will be submitted by the normal arch maintainers.
> > 
> > The combination of the four patches has been test-booted on a variety of
> > i386 hardware, and compiled for ppc64, i386, and x86-64 with about 17
> > different .configs.  It's also been runtime-tested on ia64 configs (with
> > more patches on top).
> 
> Could you try swsusp on i386, too?

Runtime, or just compiling?  

Have you noticed a real problem?

-- Dave

