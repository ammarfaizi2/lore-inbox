Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422924AbWHYX3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422924AbWHYX3U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422923AbWHYX3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:29:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422913AbWHYX3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:29:19 -0400
Date: Fri, 25 Aug 2006 16:29:02 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Cc: "David S. Miller" <davem@davemloft.net>,
       Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPV6 : segmentation offload not set correctly on TCP
 children
Message-ID: <20060825162902.2c57eabf@localhost.localdomain>
In-Reply-To: <20060825230626.GC4570@cip.informatik.uni-erlangen.de>
References: <20060821212243.GA1558@cip.informatik.uni-erlangen.de>
	<20060821150231.31a947d4@localhost.localdomain>
	<20060821222634.GC21790@cip.informatik.uni-erlangen.de>
	<20060825154353.3ecaf508@localhost.localdomain>
	<20060825230626.GC4570@cip.informatik.uni-erlangen.de>
Organization: OSDL
X-Mailer: Sylpheed-Claws 2.1.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Aug 2006 01:06:26 +0200
Thomas Glanzmann <sithglan@stud.uni-erlangen.de> wrote:

> Hello Stephen,
> thanks for the fix, it fixes the problem for me. I closed the bug. On
> which hardware did you reproduce the bug and how did you found it? Did
> you use git bisect?
> 
>         Thomas

Finding the line was luck. I spotted similar (but correct) code in
DCCP over IPV6.

-- 
Stephen Hemminger <shemminger@osdl.org>

All non-trivial abstractions, to some degree, are leaky.
