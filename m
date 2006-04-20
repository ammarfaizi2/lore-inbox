Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751269AbWDTEkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbWDTEkX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbWDTEkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:40:23 -0400
Received: from mga06.intel.com ([134.134.136.21]:20316 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751269AbWDTEkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:40:23 -0400
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25313089:sNHT17403218"
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25313081:sNHT15933715"
TrustExchangeSourcedMail: True
X-IronPort-AV: i="4.04,137,1144047600"; 
   d="scan'208"; a="25313079:sNHT16500631"
Date: Wed, 19 Apr 2006 21:37:56 -0700
From: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
To: Keith Owens <kaos@sgi.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
       Anderw Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Dean Nelson <dnc@sgi.com>, Tony Luck <tony.luck@intel.com>,
       Ananth Mavinakayanahalli <ananth@in.ibm.com>,
       Prasanna Panchamukhi <prasanna@in.ibm.com>,
       Dave M <davem@davemloft.net>, Andi Kleen <ak@suse.de>,
       Robin Holt <holt@sgi.com>
Subject: Re: [(resend)patch 0/7] Notify page fault call chain
Message-ID: <20060419213756.A6150@unix-os.sc.intel.com>
Reply-To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
References: <20060419221419.382297865@csdlinux-2.jf.intel.com> <19803.1145492837@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <19803.1145492837@ocs3.ocs.com.au>; from kaos@sgi.com on Thu, Apr 20, 2006 at 10:27:17AM +1000
X-OriginalArrivalTime: 20 Apr 2006 04:40:20.0992 (UTC) FILETIME=[8807B000:01C66434]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 10:27:17AM +1000, Keith Owens wrote:
> Anil S Keshavamurthy (on Wed, 19 Apr 2006 15:14:19 -0700) wrote:
> >Hi Andrew,
> >
> >Currently in the do_page_fault() code path, we call
> >notify_die(DIE_PAGE_FAULT, ...) to notify the page fault. 
> >The only interested components for this page fault 
> >notifications  are  Kprobes  and/or  kdb.
> 
> Only kprobes.  kdb does not care about page faults.

Oh.good to know this.

thanks,
Anil
