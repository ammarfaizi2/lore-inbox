Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261673AbSJIA7G>; Tue, 8 Oct 2002 20:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261676AbSJIA5s>; Tue, 8 Oct 2002 20:57:48 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:57852 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S261673AbSJIA5I>; Tue, 8 Oct 2002 20:57:08 -0400
Date: Tue, 8 Oct 2002 21:02:49 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: neilb@cse.unsw.edu.au, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] silence an unnescessary raid5 debugging message
Message-ID: <20021008210249.I15858@redhat.com>
References: <20021008180350.A15858@redhat.com> <15779.27330.284336.914423@notabene.cse.unsw.edu.au> <20021008193612.H15858@redhat.com> <20021008.175116.22950725.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021008.175116.22950725.davem@redhat.com>; from davem@redhat.com on Tue, Oct 08, 2002 at 05:51:16PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 05:51:16PM -0700, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Tue, 8 Oct 2002 19:36:12 -0400
>    
>    As it stands, the syslogging from the printk does more damage to
>    performance than the underlying problem.  Besides, LVM snapshots
>    are slow, but they're useful for a class of problems anyways.
> 
> He's just saying kill the real problem first, that's all.

I'm just saying that the message is the only real problem I have with 
the state of 2.4.  Sure, 2.5 deserves it fixed correctly, but I doubt 
the correct fix will make it into 2.4 anytime soon (it's far more 
dangerous than we should consider shipping in a "stable" series).

		-ben
-- 
"Do you seek knowledge in time travel?"
