Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUBYUC5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 15:02:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261431AbUBYUC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 15:02:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:59356 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261287AbUBYUCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:02:53 -0500
Date: Wed, 25 Feb 2004 12:02:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IPMI driver updates, part 1b
Message-Id: <20040225120256.10220f07.akpm@osdl.org>
In-Reply-To: <403CC667.2000403@acm.org>
References: <403B57B8.2000008@acm.org>
	<403BE39D.2080207@acm.org>
	<20040224170024.4e75a85c.akpm@osdl.org>
	<403CC667.2000403@acm.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
>  >
>  >- We have #ifdef CONFIG_HIGH_RES_TIMERS code in there?
>  >
>  Well, yes.  That's so if people add the high-res timer patch, this 
>  driver can take advantage of it.  Is that a problem?

Generally we prefer to not carry such code in the kernel tree.  But it's
relatively localised and not in a place where a lot of people go.  If it
makes your life easier and is actually maintained it is hardly the end of
the world.

