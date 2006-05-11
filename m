Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750776AbWEKUmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750776AbWEKUmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 16:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWEKUmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 16:42:49 -0400
Received: from dvhart.com ([64.146.134.43]:18661 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1750776AbWEKUms (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 16:42:48 -0400
Message-ID: <4463A1C7.6010205@mbligh.org>
Date: Thu, 11 May 2006 13:42:47 -0700
From: Martin Bligh <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashok Raj <ashok.raj@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511100215.588e89aa.akpm@osdl.org> <20060511102711.A15733@unix-os.sc.intel.com>
In-Reply-To: <20060511102711.A15733@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> On Thu, May 11, 2006 at 10:02:15AM -0700, Andrew Morton wrote:
> 
>>OK, thanks.  I'm a little surprised that this patch wasn't accompanied by a
>>problem description, really.  I mean, if a single CPU offlining takes three
>>milliseconds then why bother?
> 
> 
> It depends on whats running at the time... with some light load, i measured 
> wall clock time, i remember seeing 2 secs at times, but its been a long time
> i did that.. so take that with a pinch :-)_
> 
> i will try to get those idle and load times worked out again... the best
> i have is a  16 way, if i get help from big system oems i will send the 
> numbers out

Why is taking 30s to offline CPUs a problem?

M.
