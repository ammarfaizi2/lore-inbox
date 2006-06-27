Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161129AbWF0QA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbWF0QA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 12:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161130AbWF0QA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 12:00:26 -0400
Received: from xenotime.net ([66.160.160.81]:5041 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161129AbWF0QAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 12:00:25 -0400
Date: Tue, 27 Jun 2006 09:02:59 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Miller <davem@davemloft.net>
Cc: vonbrand@inf.utfsm.cl, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17 du jour on SPARC64: Build failure
Message-Id: <20060627090259.baad2f4b.rdunlap@xenotime.net>
In-Reply-To: <20060627.021212.92582530.davem@davemloft.net>
References: <200606270041.k5R0fZqd008665@laptop11.inf.utfsm.cl>
	<20060626182205.ba9392d2.rdunlap@xenotime.net>
	<20060627.021212.92582530.davem@davemloft.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2006 02:12:12 -0700 (PDT) David Miller wrote:

> From: "Randy.Dunlap" <rdunlap@xenotime.net>
> Date: Mon, 26 Jun 2006 18:22:05 -0700
> 
> > CONFIG_PCI is not set.  That's the build problem, although
> > I don't see which file #includes it.
> > The bad news is that when CONFIG_PCI=n, those functions just do
> > 	BUG();
> > anyway, so it won't help you much.
> 
> No SBUS drivers will use dma_*() anyways, so it's not matter.  The
> file should still build properly when CONFIG_PCI=n, and that's what
> I'll fix.

Yes, I realize that it should build.

Thanks for the SBUS info.

---
~Randy
