Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbVLHXir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbVLHXir (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbVLHXiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:38:46 -0500
Received: from fmr24.intel.com ([143.183.121.16]:33970 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932705AbVLHXiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:38:46 -0500
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
	boundary
From: Rohit Seth <rohit.seth@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
In-Reply-To: <20051208232610.GY11190@wotan.suse.de>
References: <20051208215514.GE3776@localhost.localdomain>
	 <1134083357.7131.21.camel@akash.sc.intel.com>
	 <20051208231141.GX11190@wotan.suse.de>
	 <1134084367.7131.32.camel@akash.sc.intel.com>
	 <20051208232610.GY11190@wotan.suse.de>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 08 Dec 2005 15:45:11 -0800
Message-Id: <1134085511.7131.53.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2005 23:38:17.0773 (UTC) FILETIME=[7738EDD0:01C5FC50]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 00:26 +0100, Andi Kleen wrote:

> Well if the Xen people have such requirements they can submit
> separate patches. Currently they don't seem to be interested
> at all in submitting patches to mainline, so we must work
> with the VM hackers who are interested in this (scalex86, VMware) 
> And AFAIK they only care about not having false sharing in there.
> 


Agreed.  

Though do we need to have full page allocated for each gdt (256 bytes)
then? ...possibly use kmalloc.

-rohit

