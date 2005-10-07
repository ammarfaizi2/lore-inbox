Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbVJGVVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVJGVVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 17:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJGVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 17:21:34 -0400
Received: from fmr14.intel.com ([192.55.52.68]:16869 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S932510AbVJGVVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 17:21:33 -0400
Subject: Re: FW: [PATCH 0/3] Demand faulting for huge pages
From: Rohit Seth <rohit.seth@intel.com>
To: hugh@veritas.com, agl@us.ibm.com, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, akpm@osdl.org
In-Reply-To: <B05667366EE6204181EABE9C1B1C0EB5086AF0DF@scsmsx401.amr.corp.intel.com>
References: <B05667366EE6204181EABE9C1B1C0EB5086AF0DF@scsmsx401.amr.corp.intel.com>
Content-Type: text/plain
Organization: Intel 
Date: Fri, 07 Oct 2005 14:28:37 -0700
Message-Id: <1128720518.32679.15.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Oct 2005 21:21:15.0963 (UTC) FILETIME=[0D07C8B0:01C5CB85]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-07 at 10:47 -0700, Adam Litke wrote:
>  
> 
> If I were to spend time coding up a patch to remove truncation support
> for hugetlbfs, would it be something other people would want to see
> merged as well?
> 

In its current form, there is very little use of huegtlb truncate
functionality.  Currently it only allows reducing the size of hugetlb
backing file.   

IMO it will be useful to keep and enhance this capability so that apps
can dynamically reduce or increase the size of backing files (for
example based on availability of memory at any time).

-rohit

