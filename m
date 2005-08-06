Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261959AbVHFJ5y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261959AbVHFJ5y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 05:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVHFJ5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 05:57:54 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:24228 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262049AbVHFJ5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 05:57:51 -0400
Subject: Re: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: mpm@selenic.com, ak@suse.de, akpm@osdl.org, mingo@elte.hu,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sandos@home.se
In-Reply-To: <20050806.024636.28814830.davem@davemloft.net>
References: <1123287835.18332.110.camel@localhost.localdomain>
	 <20050806015310.GA8074@waste.org>
	 <1123295548.18332.126.camel@localhost.localdomain>
	 <20050806.024636.28814830.davem@davemloft.net>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Sat, 06 Aug 2005 05:57:20 -0400
Message-Id: <1123322240.18332.131.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-06 at 02:46 -0700, David S. Miller wrote:
> Can you guys stop peeing your pants over this, put aside
> your differences, and work on a mutually acceptable fix
> for these bugs?
> 
> Much appreciated, thanks :-)

In my last email, I stated that this discussion seems to have
demonstrated that the e1000 driver's netpoll is indeed broken, and needs
to be fixed.  I submitted eariler a patch for this, but it's untested
and someone who owns an e1000 needs to try it.

As for all the netpoll issues, I'm satisfied with whatever you guys
decide.  But I've seen lots of problems posted over the netpoll and
e1000, where people send in patches that do everything but fix the
e1000, and that's where I chimed in.

Thank you, my pants are dry now :-)

-- Steve


