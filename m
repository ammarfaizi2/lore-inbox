Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVCYKAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVCYKAU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 05:00:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbVCYKAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 05:00:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:39629 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261577AbVCYKAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 05:00:17 -0500
Date: Fri, 25 Mar 2005 01:59:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: coywolf@gmail.com
Cc: coywolf@sosdg.org, linux-kernel@vger.kernel.org, james4765@cwazy.co.uk
Subject: Re: [patch] oom-killer sysrq-f fix
Message-Id: <20050325015956.13ac1d91.akpm@osdl.org>
In-Reply-To: <20050325073611.GA2510@everest.sosdg.org>
References: <20050325003316.GA31352@everest.sosdg.org>
	<20050324164435.4286ac5f.akpm@osdl.org>
	<424363BB.80207@lovecn.org>
	<20050324172127.110e9dd4.akpm@osdl.org>
	<20050325073611.GA2510@everest.sosdg.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
>
> OK, the following patch put moom into workqueue.

hm.  Simple, isn't it?

>  Do you agree to put sysrq-e and sysrq-i into workqueue too?

If you spy a deadlock then yes, I suppose we should.
