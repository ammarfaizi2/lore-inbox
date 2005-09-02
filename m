Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVIBRNM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVIBRNM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVIBRNM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:13:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:61366 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750724AbVIBRNL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:13:11 -0400
Date: Fri, 2 Sep 2005 22:42:37 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>, rmk+lkml@arm.linux.org.uk
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050902171237.GA4650@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050831165843.GA4974@in.ibm.com> <20050831171211.GB4974@in.ibm.com> <200509030143.57782.kernel@kolivas.org> <20050902175623.D6546@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050902175623.D6546@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 05:56:23PM +0100, Russell King wrote:
> Are you guys going to sync your interfaces with what ARM has, or are
> we going to have two differing dyntick interfaces in the kernel, one
> for ARM and one for x86?

Three actually, including s390 :) I know that it would be really nice to sync 
up with what is there in ARM/s390. I havent looked closely at both 
implementations. Will have a look and post an update which should keep the 
interfaces alike on all platforms.

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
