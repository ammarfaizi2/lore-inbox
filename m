Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTISSr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 14:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261679AbTISSr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 14:47:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:37077 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261677AbTISSrX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 14:47:23 -0400
Date: Fri, 19 Sep 2003 11:28:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: jbarnes@sgi.com (Jesse Barnes)
Cc: juan.villacis@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.x] additional kernel event notifications
Message-Id: <20030919112809.21fe773b.akpm@osdl.org>
In-Reply-To: <20030919181822.GA4335@sgi.com>
References: <7F740D512C7C1046AB53446D372001732DEC51@scsmsx402.sc.intel.com>
	<20030919181822.GA4335@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) wrote:
>
> Any chance of this getting into 2.6?  I for one would like to see it so
> that the performance monitoring tools can work properly without having
> to resort to syscall table patching.

If the code which uses these hooks is included in the kernel.org tree, yes.

If the code which needs the hooks is not in the kernel.org tree then people
can patch the core kernel at the same time as adding the performance
analysis patch.

If the code which needs these hooks is not appropriately licensed then
these hooks basically constitute a GPL bypass and that is not a direction
we wish to be heading in.

