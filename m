Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUBENiu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265251AbUBENiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:38:50 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64662 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265230AbUBENir (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:38:47 -0500
Date: Thu, 5 Feb 2004 19:09:11 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU barrier
Message-ID: <20040205133911.GA13005@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040205132809.GE3703@in.ibm.com> <16418.17841.293641.878787@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16418.17841.293641.878787@laputa.namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 04:31:29PM +0300, Nikita Danilov wrote:
> Dipankar Sarma writes:
>  > This patch introduces a new interface - rcu_barrier() which waits
>  > until all the RCUs queued until this call have been completed.
>  > Nikita asked for this quite a while ago for reiser4 jnodes.
>  > Sorry Nikita, if you are still using RCU in new reiserfs, 
>  > you don't need to use your own logic for this now. Just	
>  > call rcu_barrier() during umount.
>  > 
>  > If Nikita or other users use it, then I would like to push for
>  > including this.
> 
> Yes, we are still using RCU in the reiser4 (bravely). rcu_barrier()
> would allow us to get rid of some really ugly code.

Cool. Let me know if the rcu-barrier patch works for you. If it
does, I will push for its inclusion.

Thanks
Dipankar
