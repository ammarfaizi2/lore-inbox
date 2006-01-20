Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWATVfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWATVfS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWATVfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:35:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48526 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbWATVfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:35:16 -0500
Date: Fri, 20 Jan 2006 13:34:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zone_reclaim cpus_empty needs a real variable
Message-Id: <20060120133449.6886928c.akpm@osdl.org>
In-Reply-To: <20060120135845.GA8040@shadowen.org>
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	<20060120135845.GA8040@shadowen.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> wrote:
>
> On some architectures cpus_empty() attempts to take the address
>  of the mask.

That's pretty awkward.  Can they not do that?
