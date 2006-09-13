Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751029AbWIMSQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029AbWIMSQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbWIMSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:16:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:26899 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1751029AbWIMSQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:16:13 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,160,1157353200"; 
   d="scan'208"; a="126249537:sNHT869753871"
Message-ID: <45084ADA.3050604@linux.intel.com>
Date: Wed, 13 Sep 2006 20:15:54 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Jason Baron <jbaron@redhat.com>
Subject: Re: [PATCH 2/2] new bd_mutex lockdep annotation
References: <20060913174312.528491000@chello.nl> <20060913174650.432175000@chello.nl>
In-Reply-To: <20060913174650.432175000@chello.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra wrote:
> Use the gendisk partition number to set a lock class.
> 
I like this approach a whole better than what is there today (but we talked about that before ;)
It's a lot more obviously the right approach and kills a whole lot of ugly duplication

so

Acked-by: Arjan van de Ven <arjan@linux.intel.com>

> 
> --
