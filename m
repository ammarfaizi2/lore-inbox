Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751407AbWFEUO6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWFEUO6 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 16:14:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWFEUO6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 16:14:58 -0400
Received: from smtp-out.google.com ([216.239.45.12]:50333 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWFEUO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 16:14:57 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:references:in-reply-to:
	content-type:content-transfer-encoding;
	b=X6tLddjou2p0bc/klhYesnPg8v798bEYuKZbUln2HNih3OLqbM8DVL/8CbAciI6Gj
	2sqboGZfZo0oyOq2qeTYw==
Message-ID: <44849075.5070802@google.com>
Date: Mon, 05 Jun 2006 13:13:41 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Christoph Lameter <clameter@sgi.com>,
        "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
        linux-kernel@vger.kernel.org, ak@suse.de,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.17-rc5-mm1
References: <447DEF49.9070401@google.com> <20060531140652.054e2e45.akpm@osdl.org> <447E093B.7020107@mbligh.org> <20060531144310.7aa0e0ff.akpm@osdl.org> <447E104B.6040007@mbligh.org> <447F1702.3090405@shadowen.org> <44842C01.2050604@shadowen.org> <Pine.LNX.4.64.0606051137400.17951@schroedinger.engr.sgi.com> <44848DD2.7010506@shadowen.org> <Pine.LNX.4.64.0606051304360.18543@schroedinger.engr.sgi.com> <44848F45.1070205@shadowen.org>
In-Reply-To: <44848F45.1070205@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>Adding 32k swap on swapfile31.  Priority:-34 extents:1 across:32k
>>>Adding 32k swap on swapfile32.  Priority:-35 extents:1 across:32k
>>
>>That should not work at all. It should bomb out at 30 swap files with page 
>>migration on.
> 
> The implication here is that there can only be 32 entries in-toto ... it
> feels like we have at least 33/34 as the machine has swap by default ...
> more to look at!

Either way, random panics are not the appropriate response ;-)

if it can't cope with that, why isn't it failing the request ???

M.
