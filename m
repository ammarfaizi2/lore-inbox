Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVKBHQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVKBHQx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932615AbVKBHQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:16:52 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:51882 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932614AbVKBHQw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:16:52 -0500
Date: Wed, 2 Nov 2005 12:44:39 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Setting kernel data breakpoints on x86
Message-ID: <20051102071438.GA5050@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.44L0.0511011625280.4473-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0511011625280.4473-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 04:30:26PM -0500, Alan Stern wrote:
> I'm trying to debug a rather difficult data-overwriting problem, and it 
> would be a big help to be able to use a data breakpoint.
> 
> Is there any easy way of doing this?  I'd prefer not to use a kernel 
> debugger, because the address of the breakpoint and the time when it's 
> needed are determined dynamically.
> 
> Does anybody have a little lightweight procedure for setting one of the 
> x86's debug registers to point to a particular location in kernel memory 
> space?  I don't care if the whole system crashes when the debug exception 
> occurs, just so long as I can get a stack trace and find out where the 
> overwrite comes from.
> 
> 

Hi Alan

Probably watchpoint probes could be useful for this..

http://www.ussg.iu.edu/hypermail/linux/kernel/0508.3/1407.html

http://sourceware.org/ml/systemtap/2005-q3/msg00097.html

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
