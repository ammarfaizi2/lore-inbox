Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUC2SuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 13:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263085AbUC2SuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 13:50:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:18853 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263084AbUC2SuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 13:50:15 -0500
Date: Mon, 29 Mar 2004 10:50:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CAN-2003-0018 vs 2.6?
Message-Id: <20040329105009.08b0a38a.akpm@osdl.org>
In-Reply-To: <20040329131536.GA6296@lst.de>
References: <20040329131536.GA6296@lst.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:
>
> CAN-2003-0018 (Linux O_DIRECT Direct Input/Output Information Leak
> Vulnerability) is still not fixed in mainline 2.6.
> 
> Last time I pinged you you said you didn't like the fixes but we're
> getting to the point where 2.6 gets seriously used and we should start
> to care.  In fact SuSE has been adding the patches to their tree now
> which means an direct I/O API change which is kinda messy to maintain
> for XFS (which isn't even affected by the vulnerability due to it's own
> locking) that's supposed to supply vendors with uptodas.
> 
> So any plans to gets this in?

The fixes for this have been ready to go for a week or so.  It's 2.6.6-pre
material.

