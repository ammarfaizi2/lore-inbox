Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbSJYRBz>; Fri, 25 Oct 2002 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261492AbSJYRBz>; Fri, 25 Oct 2002 13:01:55 -0400
Received: from rth.ninka.net ([216.101.162.244]:53153 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261493AbSJYRBy>;
	Fri, 25 Oct 2002 13:01:54 -0400
Subject: Re: 2.5.xx kernel performance issue...
From: "David S. Miller" <davem@redhat.com>
To: "Pavan Kumar Reddy N.S." <pavan.kumar@wipro.com>
Cc: "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <000a01c27c28$0baa6e50$6009720a@wipro.com>
References: <000a01c27c28$0baa6e50$6009720a@wipro.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Oct 2002 10:20:42 -0700
Message-Id: <1035566442.19155.8.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 06:11, Pavan Kumar Reddy N.S. wrote:
> TCP and AF_UNIX socket stream bandwidth has also got drastic change.

There is debugging code enabled for the loopback interface
in 2.5.x to test out some new features in the networking stack.

Once that debugging code is removed (say in 2.6.0) these performance
drops will drop.

I have to post this every time someone complains about lmbench
performance loss in 2.5.x

