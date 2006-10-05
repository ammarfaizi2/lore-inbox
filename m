Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWJEUZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWJEUZQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWJEUZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:25:16 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:2508 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751255AbWJEUZO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:25:14 -0400
Subject: Re: 2.6.18-mm2 boot failure on x86-64
From: Steve Fox <drfickle@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: vgoyal@in.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
       Martin Bligh <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       kmannth@us.ibm.com, Andy Whitcroft <apw@shadowen.org>,
       Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <200610052108.55208.ak@suse.de>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <200610052027.02208.ak@suse.de> <20061005185217.GF20551@in.ibm.com>
	 <200610052108.55208.ak@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 05 Oct 2006 15:25:09 -0500
Message-Id: <1160079909.29690.40.camel@flooterbu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-05 at 21:08 +0200, Andi Kleen wrote:

> Mel might want to take a look (and perhaps
> also cut down a little on the ugly printks ...) 

I tested a patch from Mel which backs out the arch independent zone
sizing and got the same results (to my inexperienced eye). I've sent him
the boot log to verify they really are the same as without this
back-out.

-- 

Steve Fox
IBM Linux Technology Center
