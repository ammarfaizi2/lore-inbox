Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUGAVg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUGAVg4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266297AbUGAVg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:36:27 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:54661 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266291AbUGAVex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:34:53 -0400
Subject: Re: [PATCH][PPC64] lparcfg seq_file updates (pass2)
From: Dave Hansen <haveblue@us.ibm.com>
To: will schmidt <will_schmidt@vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PPC64 External List <linuxppc64-dev@lists.linuxppc.org>,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
In-Reply-To: <40E47EE5.3020002@vnet.ibm.com>
References: <40E47EE5.3020002@vnet.ibm.com>
Content-Type: text/plain
Message-Id: <1088717644.21679.266.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 14:34:04 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-01 at 14:15, will schmidt wrote:
>       - Answering Dave's question on the lparcfg_count_active_processors()
> 	function..  This is for the cases where we have some number of
> 	virtual processors that are different than the number of physical
> 	processors in the system.  This doesnt happen on most systems, but
> 	does occur in some of the partitioned configurations.  I've
> 	added a similar comment above the function.

But, shouldn't the number of virtual processors be what shows up in
sysfs and /proc/cpuinfo?  I can understand exporting the number total in
the machine, because that's not normally visible, but I think the number
visible to Linux is redundant.

-- Dave

