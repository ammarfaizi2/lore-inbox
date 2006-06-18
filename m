Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWFRMuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWFRMuu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 08:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWFRMuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 08:50:50 -0400
Received: from fmr18.intel.com ([134.134.136.17]:23962 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932202AbWFRMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 08:50:50 -0400
Message-ID: <44954B9B.6070209@linux.intel.com>
Date: Sun, 18 Jun 2006 14:48:27 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 2.6.16-rc6-mm2] x86: add NUMA to oops messages
References: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
In-Reply-To: <200606180815_MC3-1-C2CC-41A5@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>> and putting half of .config into the oops doesn't seem
>> like a good long term strategy.
> 
> It's just this one thing; I can't think of anything else to add...
> 

if it's compact I'd actually put the entire vermagic line there...
it'll show compiler, preempt and a whole lot of other "distinctive" features

