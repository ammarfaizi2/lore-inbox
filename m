Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261370AbVFCR5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbVFCR5X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVFCR5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:57:23 -0400
Received: from dvhart.com ([64.146.134.43]:36263 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261370AbVFCR5J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:57:09 -0400
Date: Fri, 03 Jun 2005 10:56:54 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Sonny Rao <sonnyrao@us.ibm.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, jschopp@austin.ibm.com,
       Mel Gorman <mel@csn.ul.ie>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version 12
Message-ID: <831680000.1117821414@flay>
In-Reply-To: <20050603174706.GA25663@localhost.localdomain>
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <20050603174706.GA25663@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Friday, June 03, 2005 12:47:06 -0500 Sonny Rao <sonnyrao@us.ibm.com> wrote:

> On Wed, Jun 01, 2005 at 04:28:34PM -0700, Martin J. Bligh wrote:
> <snip> 
>> Seems to me we're basically pointing a blunderbuss at memory, and 
>> blowing away large portions, and *hoping* something falls out the
>> bottom that's a big enough chunk?
> 
> Isn't this also the case with the slab shrinkers ??
> 
> We kill stuff until some free pages hopefully fall out, but this can
> be difficult when you have 20+ non-related items per page (dcache).
> 
> I think there should be a better way there as well.

Yup. Same problem, I've been looking at that too ...

M.

