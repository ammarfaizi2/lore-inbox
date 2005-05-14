Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262795AbVENQ2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbVENQ2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 12:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbVENQ2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 12:28:40 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:7066 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262795AbVENQ2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 12:28:39 -0400
Date: Sat, 14 May 2005 21:58:41 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: ntl@pobox.com, dino@in.ibm.com, Simon.Derr@bull.net,
       lse-tech@lists.sourceforge.net, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpusets+hotplug+preepmt broken
Message-ID: <20050514162841.GB32720@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050511191654.GA3916@in.ibm.com> <20050511195156.GE3614@otto> <20050511134235.5cecf85c.pj@sgi.com> <20050511135850.3df60a9f.pj@sgi.com> <20050513192331.2244ada9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050513192331.2244ada9.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 07:23:31PM -0700, Paul Jackson wrote:
> Revert the move_task_off_dead_cpu() code to its previous code, before
> cpusets were added.  If none of the remaining allowed cpus are online,
> then let the task run on any cpu, no limit.  

I would agree to that!



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
