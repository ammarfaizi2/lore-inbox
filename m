Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVAEW3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVAEW3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 17:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVAEW3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 17:29:08 -0500
Received: from p508B6A4B.dip.t-dialin.net ([80.139.106.75]:56134 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S262617AbVAEW3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 17:29:07 -0500
Date: Wed, 5 Jan 2005 23:28:48 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: James Nelson <james4765@cwazy.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 0/4] mips: remove cli()/sti() from arch/mips/*
Message-ID: <20050105222848.GA25921@linux-mips.org>
References: <20050104223327.21889.11863.64754@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104223327.21889.11863.64754@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 04:33:07PM -0600, James Nelson wrote:

> This series of patches is to remove the last cli()/sti() function calls in arch/mips.
> 
> These are the only instances in active code that grep could find.
> 
>  gt64120/ev64120/irq.c                            |    2 +-
>  jmr3927/rbhma3100/setup.c                        |    2 +-
>  tx4927/toshiba_rbtx4927/toshiba_rbtx4927_irq.c   |    2 +-
>  tx4927/toshiba_rbtx4927/toshiba_rbtx4927_setup.c |    4 ++--

The usual suspects for bitrot ...

Thanks, all four patches applied.

  Ralf
