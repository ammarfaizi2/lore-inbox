Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932230AbWHKQPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932230AbWHKQPy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWHKQPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:15:54 -0400
Received: from mga07.intel.com ([143.182.124.22]:11945 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932230AbWHKQPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:15:53 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.08,115,1154934000"; 
   d="scan'208"; a="101887204:sNHT15750147"
Message-ID: <44DCAD34.5040502@linux.intel.com>
Date: Fri, 11 Aug 2006 09:15:48 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: openib-general@openib.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix potential deadlock in mthca
References: <adad5b7ntyh.fsf@cisco.com>
In-Reply-To: <adad5b7ntyh.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
> Here's a long-standing bug that lockdep found very nicely.
> 
> Ingo/Arjan, can you confirm that the fix looks OK and I am using
> spin_lock_nested() properly?  I couldn't find much documentation or
> many examples of it, so I'm not positive this is the right way to
> handle this fix.
> 

looks correct to me;

Acked-by: Arjan van de Ven <arjan@linux.intel.com>
