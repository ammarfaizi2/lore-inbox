Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274966AbTHAXMm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 19:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274985AbTHAXMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 19:12:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:53400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274966AbTHAXMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 19:12:42 -0400
Date: Fri, 1 Aug 2003 16:00:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: dipankar@in.ibm.com, andrea@suse.de, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] RCU: Reduce size of rcu_head 1 of 2
Message-Id: <20030801160036.029e542b.akpm@osdl.org>
In-Reply-To: <20030801230235.E67442C286@lists.samba.org>
References: <20030731142545.7bcb50fb.akpm@osdl.org>
	<20030801230235.E67442C286@lists.samba.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> wrote:
>
> 	Gratuitous change to API during stable series BAD BAD BAD.  If
> you drop this it stays as is until 2.8.  The extra arg in
> unneccessary, but breaking it is worse.

There won't be any out-of-tree users by then.

