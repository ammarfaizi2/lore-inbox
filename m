Return-Path: <linux-kernel-owner+w=401wt.eu-S932828AbXALLrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932828AbXALLrx (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161081AbXALLrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:47:53 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:63982 "EHLO
	lin5.shipmail.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932828AbXALLrw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:47:52 -0500
Message-ID: <45A77565.3020503@tungstengraphics.com>
Date: Fri, 12 Jan 2007 12:47:49 +0100
From: =?ISO-8859-1?Q?Thomas_Hellstr=F6m?= <thomas@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: sv, en-us, en
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
CC: Dave Airlie <airlied@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Replace nopage() / nopfn() with fault()
References: <45A3AE70.603@tungstengraphics.com> <20070112021421.GA28341@wotan.suse.de>
In-Reply-To: <20070112021421.GA28341@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>On Tue, Jan 09, 2007 at 04:02:08PM +0100, Thomas Hellström wrote:
>  
>
>>Nick,
>>
>>We're working to slowly get the new DRM memory manager into the 
>>mainstream kernel.
>>This means we have a need for the page fault handler patch you wrote 
>>some time ago.
>>I guess we could take the no_pfn() route, but that would need a check 
>>for racing
>>unmap_mapping_range(), and other problems may arise.
>>
>>What is the current status and plans for inclusion of the fault() code?
>>    
>>
>
>Hi Thomas,
>
>fault should have gone in already, but the ordering of my patchset was
>a little bit unfortunate :P
>
>I will submit them to Andrew later today.
>
>Nick
>
>  
>
Thanks, Nick.

/Thomas.

