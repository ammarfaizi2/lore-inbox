Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264264AbUA3UgQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 15:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264267AbUA3UgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 15:36:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:37329 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264264AbUA3UgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 15:36:13 -0500
Date: Fri, 30 Jan 2004 12:37:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing export of cpu_2_node
Message-Id: <20040130123738.344975d1.akpm@osdl.org>
In-Reply-To: <20040130122036.A12659@beaverton.ibm.com>
References: <20040130122036.A12659@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> While compiling on a NUMAQ with st as a module, cpu_2_node comes up as
> undefined:
> 
> WARNING: /lib/modules/2.6.2-rc2/kernel/drivers/scsi/st.ko needs unknown symbol cpu_2_node

I'm curious to know why st.o needs cpu_to_node().  I can't make it do it
here.  Can you check the cpp output and enlighten me?

Thanks.
