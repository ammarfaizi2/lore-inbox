Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263655AbTJRACO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 20:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263659AbTJRACO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 20:02:14 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:23755 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263655AbTJRACL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 20:02:11 -0400
Subject: Re: /proc reliability & performance
From: Albert Cahalan <albert@users.sf.net>
To: "David S. Miller" <davem@redhat.com>
Cc: dada1 <dada1@cosmosbay.com>, lm@bitmover.com, albert@users.sourceforge.net,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20031017021040.4964309a.davem@redhat.com>
References: <1066356438.15931.125.camel@cube>
	 <20031017023437.GB28158@work.bitmover.com>
	 <01e601c39484$f3fa31c0$890010ac@edumazet>
	 <20031017021040.4964309a.davem@redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1066434492.15921.211.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Oct 2003 19:48:12 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-17 at 05:10, David S. Miller wrote:
> On Fri, 17 Oct 2003 10:01:53 +0200
> "dada1" <dada1@cosmosbay.com> wrote:
> 
> > A "cat /proc/net/tcp" takes too much time to even try it. :(
> > 
> > tools like "netstat" or "lsof", (even with -n flag) are just unusable.
> 
> Because they don't use the netlink TCP socket dumping
> facility which is made to handle such things much better
> than procfs ever can.

That's an accepted way to do things? Oh cool.
We just need a netlink process info dumping
facility...


