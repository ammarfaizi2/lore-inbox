Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751183AbVIYGd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbVIYGd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 02:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbVIYGd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 02:33:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19141 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751183AbVIYGd0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 02:33:26 -0400
Date: Sat, 24 Sep 2005 23:32:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: davidel@xmailserver.org, willy@w.ods.org, nish.aravamudan@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] sys_epoll_wait() timeout saga ...
Message-Id: <20050924233242.560992fb.akpm@osdl.org>
In-Reply-To: <20050925062031.GA31637@alpha.home.local>
References: <Pine.LNX.4.63.0509231108140.10222@localhost.localdomain>
	<20050924040534.GB18716@alpha.home.local>
	<29495f1d05092321447417503@mail.gmail.com>
	<20050924061500.GA24628@alpha.home.local>
	<Pine.LNX.4.63.0509240800020.31060@localhost.localdomain>
	<20050924172011.GA25997@alpha.home.local>
	<Pine.LNX.4.63.0509241113370.31327@localhost.localdomain>
	<20050924230545.3245da3f.akpm@osdl.org>
	<20050925062031.GA31637@alpha.home.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau <willy@w.ods.org> wrote:
>
> If you don't feel comfortable with so much changes at once, it's better
>  to first apply Davide's fix, then later the jiffies one, and then after,
>  I could resend the ep_poll() and sys_poll() patches to use the functions
>  in jiffies.h instead of doing their own magics.

That works for me.
