Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261608AbVDUSXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261608AbVDUSXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVDUSXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:23:39 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:18919 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S261608AbVDUSXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:23:36 -0400
Message-ID: <4267EFF4.1000307@ccs.neu.edu>
Date: Thu, 21 Apr 2005 14:24:52 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla Thunderbird 1.0.1 (Windows/20050227)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Luck, Tony" <tony.luck@intel.com>
CC: davidm@hpl.hp.com, akpm@osdl.org,
       Andreas Hirstius <Andreas.Hirstius@cern.ch>,
       Bartlomiej ZOLNIERKIEWICZ <Bartlomiej.Zolnierkiewicz@cern.ch>,
       Gelato technical <gelato-technical@gelato.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [Gelato-technical] Re: Serious performance degradation on a RAID
 with kernel 2.6.10-bk7 and later
References: <B8E391BBE9FE384DAA4C5C003888BE6F0350B3F4@scsmsx401.amr.corp.intel.com>
In-Reply-To: <B8E391BBE9FE384DAA4C5C003888BE6F0350B3F4@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luck, Tony wrote:
>>Yeah, I'm facing the same issue.  I started playing with git last
>>night.  Apart from disk-space usage, it's very nice, though I really
>>hope someone puts together a web-interface on top of git soon so we
>>can seek what changed when and by whom.
> 
> 
> Disk space issues?  A complete git repository of the Linux kernel with
> all changesets back to 2.4.0 takes just over 3G ... which is big compared
> to BK, but 3G of disk only costs about $1 (for IDE ... if you want 15K rpm
> SCSI, then you'll pay a lot more).  Network bandwidth is likely to be a
> bigger problem.
> 

That said, is there any plan to change how this functions in the future 
to solve these problems?  I.e. have it not use so much diskspace and 
thus use less bandwith.  Am I misunderstanding in assuming that after
say 1000 commits go into the tree it could end up several megs or gigs 
bigger?

If that is the case might it not be more prudent to sort this out now?

> There's a prototype web i/f at http://grmso.net:8090/ that's already looking
> fairly slick.
>

Yes it is very slick.  Kudos to the creator.

-sb


> -Tony


