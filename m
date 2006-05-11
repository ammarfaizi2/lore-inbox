Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWEKR1o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWEKR1o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbWEKR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 13:27:44 -0400
Received: from mga06.intel.com ([134.134.136.21]:17958 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030389AbWEKR1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 13:27:43 -0400
TrustInternalSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.05,116,1146466800"; 
   d="scan'208"; a="34860147:sNHT85901956"
Date: Thu, 11 May 2006 10:27:12 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ashok Raj <ashok.raj@intel.com>, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org, zwane@linuxpower.ca, vatsa@in.ibm.com
Subject: Re: [PATCH 0/10] bulk cpu removal support
Message-ID: <20060511102711.A15733@unix-os.sc.intel.com>
References: <1147067137.2760.77.camel@sli10-desk.sh.intel.com> <20060510230606.076271b2.akpm@osdl.org> <20060511095308.A15483@unix-os.sc.intel.com> <20060511100215.588e89aa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060511100215.588e89aa.akpm@osdl.org>; from akpm@osdl.org on Thu, May 11, 2006 at 10:02:15AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2006 at 10:02:15AM -0700, Andrew Morton wrote:
> 
> OK, thanks.  I'm a little surprised that this patch wasn't accompanied by a
> problem description, really.  I mean, if a single CPU offlining takes three
> milliseconds then why bother?

It depends on whats running at the time... with some light load, i measured 
wall clock time, i remember seeing 2 secs at times, but its been a long time
i did that.. so take that with a pinch :-)_

i will try to get those idle and load times worked out again... the best
i have is a  16 way, if i get help from big system oems i will send the 
numbers out
> 
> I assume it must take much longer, else you wouldn't have written the code.
> Have you any ballpark numbers for how long it _does_ take?

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
