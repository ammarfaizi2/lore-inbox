Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUJYFEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUJYFEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 01:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbUJYFEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 01:04:41 -0400
Received: from ozlabs.org ([203.10.76.45]:27780 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261420AbUJYFEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 01:04:39 -0400
Subject: Re: [RFC/PATCH] Per-device parameter support (13/16)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041023043138.GN3456@home-tj.org>
References: <20041023043138.GN3456@home-tj.org>
Content-Type: text/plain
Date: Mon, 25 Oct 2004 15:04:36 +1000
Message-Id: <1098680676.8098.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-23 at 13:31 +0900, Tejun Heo wrote:
> +static int
> +#ifndef CONFIG_MODULES
> +__init
> +#endif

This looks like a job for "__init_or_module", BTW.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

