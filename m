Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263351AbTJQJN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 05:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTJQJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 05:13:26 -0400
Received: from rth.ninka.net ([216.101.162.244]:15751 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263351AbTJQJNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 05:13:25 -0400
Date: Fri, 17 Oct 2003 02:10:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: "dada1" <dada1@cosmosbay.com>
Cc: lm@bitmover.com, albert@users.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: /proc reliability & performance
Message-Id: <20031017021040.4964309a.davem@redhat.com>
In-Reply-To: <01e601c39484$f3fa31c0$890010ac@edumazet>
References: <1066356438.15931.125.camel@cube>
	<20031017023437.GB28158@work.bitmover.com>
	<01e601c39484$f3fa31c0$890010ac@edumazet>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Oct 2003 10:01:53 +0200
"dada1" <dada1@cosmosbay.com> wrote:

> A "cat /proc/net/tcp" takes too much time to even try it. :(
> 
> tools like "netstat" or "lsof", (even with -n flag) are just unusable.

Because they don't use the netlink TCP socket dumping
facility which is made to handle such things much better
than procfs ever can.
