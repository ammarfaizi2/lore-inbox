Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161351AbWASTY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161351AbWASTY4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161343AbWASTY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:24:56 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:57018 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161351AbWASTYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:24:54 -0500
Message-ID: <43CFE77B.3090708@austin.ibm.com>
Date: Thu, 19 Jan 2006 13:24:43 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/5] Reducing fragmentation using zones
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
In-Reply-To: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Benchmark comparison between -mm+NoOOM tree and with the new zones

I know you had also previously posted a very simplified version of your real 
fragmentation avoidance patches.  I was curious if you could repost those with 
the other benchmarks for a 3 way comparison.  The simplified version got rid of 
a lot of the complexity people were complaining about and in my mind still seems 
like preferable direction.

Zone based approaches are runtime inflexible and require boot time tuning by the 
sysadmin.  There are lots of workloads that "reasonable" defaults for a zone 
based approach would cause the system to regress terribly.

-Joel
