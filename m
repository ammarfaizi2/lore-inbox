Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932751AbVLHXo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932751AbVLHXo6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 18:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932750AbVLHXo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 18:44:58 -0500
Received: from fmr22.intel.com ([143.183.121.14]:52130 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S932751AbVLHXo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 18:44:57 -0500
Subject: Re: [discuss] [patch] x86_64:  align and pad x86_64 GDT on page
	boundary
From: Rohit Seth <rohit.seth@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, zach@vmware.com,
       shai@scalex86.org, nippung@calsoftinc.com
In-Reply-To: <1134085511.7131.53.camel@akash.sc.intel.com>
References: <20051208215514.GE3776@localhost.localdomain>
	 <1134083357.7131.21.camel@akash.sc.intel.com>
	 <20051208231141.GX11190@wotan.suse.de>
	 <1134084367.7131.32.camel@akash.sc.intel.com>
	 <20051208232610.GY11190@wotan.suse.de>
	 <1134085511.7131.53.camel@akash.sc.intel.com>
Content-Type: text/plain
Organization: Intel 
Date: Thu, 08 Dec 2005 15:50:43 -0800
Message-Id: <1134085843.7131.55.camel@akash.sc.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Dec 2005 23:43:48.0961 (UTC) FILETIME=[3CA03510:01C5FC51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-08 at 15:45 -0800, Rohit Seth wrote:

> 
> 
> Agreed.  
> 
> Though do we need to have full page allocated for each gdt (256 bytes)
> then? ...possibly use kmalloc.
> 


sorry, forgot about the false sharing part.

-rohit

