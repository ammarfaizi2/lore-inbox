Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264234AbTH1TgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTH1TgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 15:36:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:61082 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264234AbTH1TgQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 15:36:16 -0400
Date: Thu, 28 Aug 2003 12:20:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make voyager work again after the cpumask_t changes
Message-Id: <20030828122006.0c9b4aa4.akpm@osdl.org>
In-Reply-To: <20030828193123.GI4306@holomorphy.com>
References: <1062097375.1952.41.camel@mulgrave>
	<20030828121016.2c0e2716.akpm@osdl.org>
	<20030828193123.GI4306@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> > (Actually it is legitimate: you may want to run a NR_CPUS=48 kernel on a
> > 2-way voyager just for testing purposes).  I'll drop your patch in as-is,
> > and maybe Bill can take a look at cpumaskifying it sometime?
> 
> I'm not convinced it's worth it; AIUI there are architectural limits to
> Voyager that prevent it from ever supporting > 32x in hardware,

Sure.  But we want a kernel which was compiled with NR_CPUS>32 to still
boot and run correctly on voyager.

Yes, the code as-is will happen to work, but dtrt and all that.

