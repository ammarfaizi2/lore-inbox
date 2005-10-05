Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbVJERvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbVJERvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 13:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbVJERvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 13:51:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:56771 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030302AbVJERvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 13:51:24 -0400
Subject: Re: [PATCH 3/7] Fragmentation Avoidance V16: 003_fragcore
From: Dave Hansen <haveblue@us.ibm.com>
To: Mel Gorman <mel@csn.ul.ie>
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jschopp@austin.ibm.com, lhms <lhms-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0510051834250.16421@skynet>
References: <20051005144546.11796.1154.sendpatchset@skynet.csn.ul.ie>
	 <20051005144602.11796.53850.sendpatchset@skynet.csn.ul.ie>
	 <1128530908.26009.28.camel@localhost>
	 <Pine.LNX.4.58.0510051812040.16421@skynet>
	 <1128532920.26009.43.camel@localhost>
	 <Pine.LNX.4.58.0510051834250.16421@skynet>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:51:10 -0700
Message-Id: <1128534670.26009.48.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-05 at 18:45 +0100, Mel Gorman wrote:
> The problem is that by putting all the changes to this function in another
> patch, the kernel will not build after applying 003_fragcore. I am
> assuming that is bad. I think it makes sense to leave this patch as it is,
> but have a 004_showfree patch that adds the type_names[] array and a more
> detailed printout in show_free_areas. The remaining patches get bumped up
> a number.
> 
> Would you be happy with that?

Seems reasonable to me.

-- Dave

