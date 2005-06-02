Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261331AbVFBVEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbVFBVEj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 17:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFBVDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 17:03:06 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:31460 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261280AbVFBULA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 16:11:00 -0400
Message-ID: <429F67C4.9060506@austin.ibm.com>
Date: Thu, 02 Jun 2005 15:10:44 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ray Bryant <raybry@engr.sgi.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Mel Gorman <mel@csn.ul.ie>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Avoiding external fragmentation with a placement policy Version
 12
References: <20050531112048.D2511E57A@skynet.csn.ul.ie> <429E20B6.2000907@austin.ibm.com> <429E4023.2010308@yahoo.com.au> <423970000.1117668514@flay> <429E483D.8010106@yahoo.com.au> <434510000.1117670555@flay> <429E50B8.1060405@yahoo.com.au> <429F2B26.9070509@austin.ibm.com> <429F631E.6020401@engr.sgi.com>
In-Reply-To: <429F631E.6020401@engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could someone point me at the "Page migration defrag" patch, or
> describe what this is.  Does this depend on the page migration
> patches from memory hotplug to move pages or is it something
> different?

I don't think anybody has actually written such a patch yet (correct me 
if I'm wrong).  When somebody does it will certainly depend on the page 
migration patches.  As far as describing what it is, the concept is 
pretty simple.  Migrate in use pieces of memory around to make lots of 
smaller unallocated memory into fewer larger unallocated memory.

