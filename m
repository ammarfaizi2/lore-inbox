Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268455AbUHaNE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268455AbUHaNE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 09:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268144AbUHaNE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 09:04:28 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:3491 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268329AbUHaNCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 09:02:10 -0400
Date: Tue, 31 Aug 2004 18:34:02 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: davem@redhat.com
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       Dipankar <dipankar@in.ibm.com>, paulmck@us.ibm.com
Subject: Re: [RFC] Use RCU for tcp_ehash lookup
Message-ID: <20040831130402.GB5534@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040831125941.GA5534@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040831125941.GA5534@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 06:29:41PM +0530, Srivatsa Vaddagiri wrote:
> I found _significant_ reduction in profile count (~56% savings)
> for __tcp_v4_lookup_established if it is made lock-free. 

I had made __tcp_v4_lookup_established to be a function call (rather
than an inline function) to gather readprofile statistics for the same.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
