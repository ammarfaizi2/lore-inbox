Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbUDPTEE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 15:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbUDPTEE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 15:04:04 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:25844 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261610AbUDPTD7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 15:03:59 -0400
Message-ID: <40802E69.7040506@sgi.com>
Date: Fri, 16 Apr 2004 14:05:13 -0500
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'David Gibson'" <david@gibson.dropbear.id.au>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, lse-tech@lists.sourceforge.net,
       "'Andy Whitcroft'" <apw@shadowen.org>,
       "'Andrew Morton'" <akpm@osdl.org>
Subject: Re: hugetlb demand paging patch part [2/3]
References: <20040416032725.GG12735@zax> <200404160413.i3G4DcF13729@unix-os.sc.intel.com> <20040416044917.GB26707@zax>
In-Reply-To: <20040416044917.GB26707@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

Is there a big user demand for copy-on-write support for hugetlb pages?
I can understand the rationale for making hugetlb pages behave more like user 
pages, and fixing the problem that hugetlb pages are shared across fork via 
MAP_SHARE semantics regardless of whether the user requests MAP_PRIVATE or 
not, but it just doesn't strike me as something that anyone who uses hugetlb 
pages would actually want.

Of course, YRMV (your requirements may vary).  :-)

'David Gibson' wrote:
> 
> Well, I'm attempting to understand the hugepage code across all the
> archs, so that I can try to implement copy-on-write with a minimum of
> arch specific gunk.  Simplifying and consolidating the existing code
> across archs would be a helpful first step, if possible.
> 

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------

