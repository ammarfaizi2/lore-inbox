Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVCZVId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVCZVId (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVCZVIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:08:32 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:13223 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261263AbVCZVIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:08:30 -0500
Subject: Re: [RFC][PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <4245CC80.10306@osdl.org>
References: <E1DEwlP-0006BQ-00@kernel.beaverton.ibm.com>
	 <4244D068.3080900@osdl.org> <1111863649.9691.100.camel@localhost>
	 <4245CC80.10306@osdl.org>
Content-Type: text/plain
Date: Sat, 26 Mar 2005 13:08:23 -0800
Message-Id: <1111871303.9691.110.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-03-26 at 12:56 -0800, Randy.Dunlap wrote:
> I wasn't trying to catch you, but I've already looked at
> all 4 patches in the series and I still can't find an
> option that is labeled/described as "Sparse Memory"....
> The word "sparse" isn't even in patch 3/4... maybe
> there is something missing?

Nope, you're not missing anything.  I'm just a little mixed up.  You can
find the actual "Sparse Memory" option in this patch:

http://sr71.net/patches/2.6.12/2.6.12-rc1-mhp2/broken-out/B-sparse-151-add-to-mm-Kconfig.patch

I could easily remove the references to it in the patches that I posted
RFC, but I hoped that they would get in quickly enough that it wouldn't
matter.  Also, the help option does say that all of the options probably
won't show up.  So, users shouldn't be horribly confused if they don't
see the sparsemem option.

-- Dave

