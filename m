Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265494AbUFXULO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265494AbUFXULO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 16:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUFXULO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 16:11:14 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:23309 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265494AbUFXULL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 16:11:11 -0400
Message-ID: <40DB39E7.3060904@techsource.com>
Date: Thu, 24 Jun 2004 16:30:31 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       "lkml >> Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Elastic Quota File System (EQFS)
References: <40d9ac40.674.0@eth.net> <200406231853.35201.mrwatts@fast24.co.uk> <1088016048.15211.10.camel@sage.kitchen> <001901c459cd_bc436e40_868209ca@home> <20040624115019.GA3614@suse.de> <20040624141742.GD698@openzaurus.ucw.cz> <40DB3263.40600@dynextechnologies.com>
In-Reply-To: <40DB3263.40600@dynextechnologies.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Fao, Sean wrote:

> I fail to understand the point you're trying to make.  Are you 
> suggesting that a feature doesn't necessarily have to be implemented, 
> just because it's there?  If so, the proposed idea on the "elastic" file 
> system differs greatly.  Cached content, for instance, speeds up the 
> browsing experience *without* hindering the ability of the application 
> to function normally.  Caching is a true enhancement --in most 
> circumstances.  I can personally see no way to implement EQFS without 
> greatly exasperating end users with its shortcomings.


What you need is a small number of fast, expensive drives, and a large 
array of cheap drives, and use the fast drives as a cache for user files.

But this is completely different from elastic quotas.

My solution to this would be to have large arrays of cheap disks and put 
lots of RAM in the server and let RAM be the cache.


