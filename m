Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTJRGgL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbTJRGgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 02:36:11 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:1286 "EHLO www.home.local")
	by vger.kernel.org with ESMTP id S261368AbTJRGgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 02:36:09 -0400
Date: Sat, 18 Oct 2003 08:35:59 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /proc reliability & performance
Message-ID: <20031018063559.GD16761@alpha.home.local>
References: <1066356438.15931.125.camel@cube> <20031017023437.GB28158@work.bitmover.com> <01e601c39484$f3fa31c0$890010ac@edumazet> <20031017021040.4964309a.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017021040.4964309a.davem@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 02:10:40AM -0700, David S. Miller wrote:
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

Hmmm very interesting. And is there an equivalent replacement for
/proc/net/ip_conntrack ? And if not, what would be needed to implement it ?

Willy

