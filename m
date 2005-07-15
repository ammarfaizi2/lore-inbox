Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbVGOLtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbVGOLtz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 07:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263270AbVGOLtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 07:49:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:30398 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261897AbVGOLty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 07:49:54 -0400
Date: Fri, 15 Jul 2005 13:49:53 +0200
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64: print processor number in show_regs
Message-ID: <20050715134953.7f659467@basil.nowhere.org>
In-Reply-To: <Pine.LNX.4.61.0507150500410.16053@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0507150440280.16055@montezuma.fsmlabs.com>
	<Pine.LNX.4.61.0507150500410.16053@montezuma.fsmlabs.com>
X-Mailer: Sylpheed-Claws 1.0.3 (GTK+ 1.2.10; x86_64-suse-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2005 05:04:57 -0600 (MDT)
Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:


>  void show_regs(struct pt_regs *regs)
>  {
> +	printk("CPU %d:", smp_processor_id());

Isn't there a space after the : missing here?

-Andi
