Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268971AbUJQAQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268971AbUJQAQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 20:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268961AbUJQAQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 20:16:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:32675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268972AbUJQAQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 20:16:52 -0400
Date: Sat, 16 Oct 2004 17:14:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
Message-Id: <20041016171458.4511ad8b.akpm@osdl.org>
In-Reply-To: <4171B23F.6060305@pobox.com>
References: <41719537.1080505@pobox.com>
	<417196AA.3090207@pobox.com>
	<20041016154818.271a394b.akpm@osdl.org>
	<4171B23F.6060305@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> > I'd be suspecting the vmscan.c change, but we allegedly fixed that later on.
>  > Can you try reverting it?  (Can't reproduce the problem here)
> 
> 
>  Verified -- reverting the vmscan.c changeset (attached) fixed my hang.

Can we get a sysrq-M dump from that machine please?
