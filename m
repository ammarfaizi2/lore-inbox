Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbVKEAgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbVKEAgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbVKEAgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:36:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:65177 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751376AbVKEAgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:36:06 -0500
Date: Fri, 4 Nov 2005 16:35:57 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
Message-ID: <20051105003557.GC5397@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com> <20051104231800.GB25545@w-mikek2.ibm.com> <1131149070.29195.41.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1131149070.29195.41.camel@gaston>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 11:04:30AM +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2005-11-04 at 15:18 -0800, Mike Kravetz wrote:
> > Add the create_section_mapping() routine to create hptes for memory
> > sections dynamically added after system boot.
> > 
> > Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> This patch will have to be slightly reworked on top of the 64k pages
> one. It should be trivial though.

OK.  I'll respin on top of your patch at:

http://gate.crashing.org/~benh/ppc64-64k-pages.diff

Let me know if there is a different version going upstream.
-- 
Mike
