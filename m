Return-Path: <linux-kernel-owner+w=401wt.eu-S932309AbWLLRzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWLLRzk (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:55:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWLLRzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:55:40 -0500
Received: from smtp.osdl.org ([65.172.181.25]:50959 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932309AbWLLRzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:55:38 -0500
Date: Tue, 12 Dec 2006 09:53:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
       jffs-dev@axis.com, David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH/RFC] Delete JFFS (version 1)
Message-Id: <20061212095359.51483704.akpm@osdl.org>
In-Reply-To: <457EA2FE.3050206@garzik.org>
References: <457EA2FE.3050206@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2006 07:39:26 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> I have created the 'kill-jffs' branch of 
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git that 
> removes fs/jffs.
> 
> I argue that you can count the users (who aren't on 2.4) on one hand, 
> and developers don't seem to have cared for it in ages.
> 
> People are already talking about jffs2 replacements, so I propose we zap 
> jffs in 2.6.21.

It would be good to provide unignorable notice of this in 2.6.20.  Via a
loud printk, or perhaps even CONFIG_BROKEN or CONFIG_EMBEDDED.
