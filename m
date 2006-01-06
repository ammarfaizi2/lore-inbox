Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752555AbWAFUgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555AbWAFUgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 15:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752553AbWAFUgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 15:36:00 -0500
Received: from fmr22.intel.com ([143.183.121.14]:19598 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752552AbWAFUf6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 15:35:58 -0500
Subject: Re: [PATCH] ia64: change defconfig to NR_CPUS==1024
From: Rohit Seth <rohit.seth@intel.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Matthew Wilcox <matthew@wil.cx>,
       "Luck, Tony" <tony.luck@intel.com>, hawkes@sgi.com,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       John Hesterberg <jh@sgi.com>, Greg Edwards <edwardsg@sgi.com>
In-Reply-To: <1136573948.2940.65.camel@laptopd505.fenrus.org>
References: <1136573948.2940.65.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Organization: Intel 
Date: Fri, 06 Jan 2006 12:42:25 -0800
Message-Id: <1136580145.31992.9.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2006 20:35:43.0068 (UTC) FILETIME=[C3B059C0:01C61300]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 10:59 -0800, Arjan van de Ven wrote:
> 
> > Vendors look for the upstream defaults and orient themselves on the
> > defconfig.
> 
> they do? That's news to me. I've worked at a vendor for almost 5
> years,
> 3 1/2 years of which I was the person who decided on the configs (with
> external input of course). In those 3 1/2 years I *never* looked at
> defconfig. *never*. And I don't expect other vendor kernel owners to
> do
> things differently; when a config option needs deciding you look at
> the
> description and pick a good value. That's it. Defconfig doesn't
> matter.
> 

IMO something like 128 is a good number as a default for most IA-64
machines.  As Arjan said above, OSVs almost always have their own
reasons and input to choose this number.  And lately there is a trend of
having at least two kernels, one for mostly used platforms and the other
one for bigger configurations.

-rohit

