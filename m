Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751430AbWEOTpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430AbWEOTpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWEOTpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 15:45:18 -0400
Received: from dvhart.com ([64.146.134.43]:28903 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751430AbWEOTpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 15:45:16 -0400
Message-ID: <4468DA46.2030109@mbligh.org>
Date: Mon, 15 May 2006 12:45:10 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Whitcroft <apw@shadowen.org>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH] x86 NUMA panic compile error
References: <20060515005637.00b54560.akpm@osdl.org>	<20060515140811.GA23750@shadowen.org>	<20060515175306.GA18185@elte.hu>	<20060515110814.11c74d70.akpm@osdl.org>	<4468C3B8.8090502@shadowen.org> <20060515112456.0624d498.akpm@osdl.org>
In-Reply-To: <20060515112456.0624d498.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>>>So it is perhaps reasonable to do this panic, but only if !CONFIG_EMBEDDED? 
>>>(It really is time to start renaming CONFIG_EMBEDDED to CONFIG_DONT_DO_THIS
>>>or something).
>>
>>How about CONFIG_EXPERIMENTAL?
> 
> 
> Probably CONFIG_ADVANCED would be closer.

It defaults to off already - people have to explicitly enable it.

Plus the original point was to be able to build one kernel that'd work
across NUMA and non-NUMA boxes.

M.
