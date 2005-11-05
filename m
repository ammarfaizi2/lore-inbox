Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbVKEAo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVKEAo2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbVKEAo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:44:28 -0500
Received: from gate.crashing.org ([63.228.1.57]:62163 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751388AbVKEAo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:44:27 -0500
Subject: Re: [PATCH 1/4] Memory Add Fixes for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
In-Reply-To: <20051105003557.GC5397@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
	 <20051104231800.GB25545@w-mikek2.ibm.com>
	 <1131149070.29195.41.camel@gaston> <20051105003557.GC5397@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Sat, 05 Nov 2005 11:43:07 +1100
Message-Id: <1131151387.29195.43.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-11-04 at 16:35 -0800, Mike Kravetz wrote:
> On Sat, Nov 05, 2005 at 11:04:30AM +1100, Benjamin Herrenschmidt wrote:
> > On Fri, 2005-11-04 at 15:18 -0800, Mike Kravetz wrote:
> > > Add the create_section_mapping() routine to create hptes for memory
> > > sections dynamically added after system boot.
> > > 
> > > Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> > 
> > This patch will have to be slightly reworked on top of the 64k pages
> > one. It should be trivial though.
> 
> OK.  I'll respin on top of your patch at:
> 
> http://gate.crashing.org/~benh/ppc64-64k-pages.diff
> 
> Let me know if there is a different version going upstream

I'll check if it still applied after linus pulls the next round of ppc
updates

Ben.


