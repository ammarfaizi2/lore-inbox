Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbUDFPCN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263854AbUDFPCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:02:13 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:24523 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263866AbUDFPB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:01:57 -0400
Date: Tue, 6 Apr 2004 20:33:03 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: rusty@au1.ibm.com, nickpiggin@yahoo.com.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org, lhcs-devel@lists.sourceforge.net
Subject: Re: [Experimental CPU Hotplug PATCH] - Move migrate_all_tasks to CPU_DEAD handling
Message-ID: <20040406150303.GA8996@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20040405121824.GA8497@in.ibm.com> <20040406072543.GA21626@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406072543.GA21626@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 09:25:43AM +0200, Ingo Molnar wrote:
> We should prefer simplicity and debuggability over cleverness of 
> implementation - it's not like we'll
> have hotplug systems on everyone's desk in the next year or so.

I felt that adding idle task to front of runqueue and thereby avoid
the stop-machine overhead to a great extent is simple! Is there any 
complications you see arising out of this?

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
