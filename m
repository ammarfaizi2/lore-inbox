Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUHKPQ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUHKPQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHKPQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:16:26 -0400
Received: from mtagate2.uk.ibm.com ([195.212.29.135]:59578 "EHLO
	mtagate2.uk.ibm.com") by vger.kernel.org with ESMTP id S267976AbUHKPQY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:16:24 -0400
Message-ID: <411A3760.7030902@watson.ibm.com>
Date: Wed, 11 Aug 2004 11:12:32 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lse-tech@lists.sourceforge.net
CC: hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408071722.36705.efocht@hpce.nec.com> <2447730000.1091976606@[10.10.2.4]> <200408111140.14466.efocht@hpce.nec.com>
In-Reply-To: <200408111140.14466.efocht@hpce.nec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erich Focht wrote:
> On Sunday 08 August 2004 16:50, Martin J. Bligh wrote:
> 
>>I don't think CKRM is anything like as far away from being ready as
>>you seem to be implying - we're talking about a month or two, I
>>think.
> 
> 
> Shailab's email shows that we're talking about several months. He also
> agreed with pushing cpusets towards the -mm tree.

CKRM with its current interfaces is ready for a spin in the -mm tree 
today. But if we go with the split controllers idea, we'll be delayed 
by two or three months (the changes to the codebase are not very large 
since we internally do have quite a bit of separation between the 
controllers...its mostly an interface issue).

I would estimate that the following will be available in two-three months:
CKRM framework with per-controller modifications suggested
1 version each of the controllers
classification engines


Please note that acceptance of CKRM the framework is not tied into 
acceptance of any particular CKRM controller or the classification 
engines (that was one of our objectives !). So its quite possible that 
only the framework and the least intrusive controllers will be found 
acceptable for -mm inclusion initially and we are asked to keep 
iterating on the others based on suggestions.

-- Shailabh
