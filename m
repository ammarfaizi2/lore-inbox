Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264803AbUEKPs0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264803AbUEKPs0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 11:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUEKPs0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 11:48:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50416 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S264803AbUEKPsS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 11:48:18 -0400
Subject: RE: [2.6.6 PATCH] Exposing EFI memory map
From: Dave Hansen <haveblue@us.ibm.com>
To: Sourav Sen <souravs@india.hp.com>
Cc: "'Greg KH'" <greg@kroah.com>, Matt_Domsch@dell.com,
       Matthew E Tolentino <matthew.e.tolentino@intel.com>,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <00b201c43766$7646a670$39624c0f@india.hp.com>
References: <00b201c43766$7646a670$39624c0f@india.hp.com>
Content-Type: text/plain
Message-Id: <1084290121.1091.62.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 11 May 2004 08:42:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-11 at 07:44, Sourav Sen wrote:
> + I think you should address the other issues in this thread before
> + worrying about the sysfs interface (why have this at all, incorrect
> + data for hotplug mem, etc.)
> + 
> 	I did not hear whether the idea of updating efi memory map on a 
> hotplug is good or bad. In any case, can somebody tell me to how do 
> I get the available physical range map (only the ranges that VM is 
> using at a given point in time) from userland. I believe I outlined 
> a legitimate requirement earlier in this thread :-)

Let me paraphrase: exporting generic information in an architecture or
firmware-specific way in sysfs is bad.

I apologize, but I think I missed yout legitimate requirements earlier
in the thread.  Could you briefly remind me?

-- Dave

