Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCZTBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCZTBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 14:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261227AbVCZTBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 14:01:08 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:38359 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261223AbVCZTBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 14:01:06 -0500
Subject: Re: [RFC][PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4244D068.3080900@osdl.org>
References: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>
	 <4244D068.3080900@osdl.org>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 11:00:49 -0800
Message-Id: <1111863649.9691.100.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 19:00 -0800, Randy.Dunlap wrote:
...
> > +config DISCONTIGMEM
> > +	bool "Discontigious Memory"
> > +	depends on ARCH_DISCONTIGMEM_ENABLE
> > +	help
> > +	  If unsure, choose this option over "Sparse Memory".
> Same question....

It's in the third patch in the series.  They were all together at one
point and I was trying to be lazy, but you caught me :)

-- Dave

