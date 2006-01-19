Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161105AbWASQn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161105AbWASQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 11:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161231AbWASQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 11:43:58 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25267 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161105AbWASQn5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 11:43:57 -0500
Subject: Re: [2.6 patch] the scheduled removal of the obsolete raw driver
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, lkml <linux-kernel@vger.kernel.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <20060118194103.5c569040.akpm@osdl.org>
References: <20060119030251.GG19398@stusta.de>
	 <20060118194103.5c569040.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 08:44:31 -0800
Message-Id: <1137689071.4966.190.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 19:41 -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > Let's do the scheduled removal of the obsolete raw driver in 2.6.17.
> > 
> 
> heh.  I was just thinking that I hadn't heard from Badari and Ken in a while.
> 
> I doubt if this'll fly.  We're stuck with it.

>From the customer perspective, it would be nice to have "raw", since
they are used to it.

Now, putting on my "community hat" - we gave enough notice about the
removal. Few major distro releases happend after that. So, I am not
really going to complain - if it goes away.

But again, its really useful to have raw driver to do simple "dd" tests
to test raw performance for disks (for comparing with filesystems, block
devices etc..). Without that, we need to add option to "dd" for
O_DIRECT.

Thanks,
Badari

