Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261293AbSJUNkb>; Mon, 21 Oct 2002 09:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261328AbSJUNkb>; Mon, 21 Oct 2002 09:40:31 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:22547 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261293AbSJUNka>; Mon, 21 Oct 2002 09:40:30 -0400
Date: Mon, 21 Oct 2002 23:46:24 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: David Woodhouse <dwmw2@infradead.org>
cc: linux-kernel@vger.kernel.org, <netdev@oss.sgi.com>
Subject: Re: rtnetlink interface state monitoring problems.
In-Reply-To: <27964.1035199084@passion.cambridge.redhat.com>
Message-ID: <Mutt.LNX.4.44.0210212342070.29133-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, David Woodhouse wrote:

>  1. I appear to need CAP_NET_ADMIN to bind to the netlink groups which give
> 	me this  information. I can poll for it just fine, but need 
> 	elevated privs to be notified. Why is this, and is there a workaround?

Andi Kleen implemented a simple and effective workaround this for 2.4
which has gone into the tree (see netlink_set_nonroot() in rtnetlink.c).  

Another more complicated solution was partially developed for 2.5, but is
unlikely to make it in by Halloween.


- James
-- 
James Morris
<jmorris@intercode.com.au>


