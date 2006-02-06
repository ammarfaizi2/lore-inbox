Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWBFLqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWBFLqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 06:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbWBFLqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 06:46:37 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:36206 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1750947AbWBFLqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 06:46:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=lpgPTDEllqW+W0kFjwu9/0HmH493SDxgZCMl2owmn8OPOEBjHCH/lC1+BBjexxNo2cnWBoGqceW98yc6J2MMRiepv0+vYMH8Q6IFBfbJ7p0JAmpYGnNVg8GSavSjCzfOfCpbtmVqflhssbgB9khA14WBV+Oah9YNc+SXnXjEKDM=  ;
Message-ID: <43E73719.5080309@yahoo.com.au>
Date: Mon, 06 Feb 2006 22:46:33 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, hawkes@sgi.com, steiner@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] sched: fix group power for allnodes_domains
References: <20060203171841.A19490@unix-os.sc.intel.com>
In-Reply-To: <20060203171841.A19490@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> Current sched groups power calculation for allnodes_domains is wrong. We should
> really be using cumulative power of the physical packages in that group
> (similar to the calculation in node_domains)
> 
> Appended patch fixes this issue. This request is for inclusion in -mm and hence
> the patch is against 2.6.16-rc1-mm5(as multi core sched patch in -mm was 
> touching this area)
> 
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>

Good catch,

Acked-by: Nick Piggin <npiggin@suse.de>

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
