Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263301AbUFFLSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263301AbUFFLSE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 07:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbUFFLSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 07:18:04 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:38406 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263301AbUFFLR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 07:17:56 -0400
Subject: Re: WINE + NX (No eXecute) support for x86, 2.6.7-rc2-bk2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mike McCormack <mike@codeweavers.com>, mingo@elte.hu,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040606084326.GA6716@infradead.org>
References: <40C2B51C.9030203@codeweavers.com>
	 <20040606073241.GA6214@infradead.org> <40C2E045.8090708@codeweavers.com>
	 <20040606081021.GA6463@infradead.org> <40C2E5DC.8000109@codeweavers.com>
	 <20040606083924.GA6664@infradead.org> <20040606084326.GA6716@infradead.org>
Content-Type: text/plain
Message-Id: <1086520670.1675.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Sun, 06 Jun 2004 13:17:51 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-06-06 at 10:43, Christoph Hellwig wrote:

> And btw, if you'd have read the whole thread you'd have seen that I argued
> against mergign the randomization and address space layout changes into
> 2.6, and such changes during stable series are bad.  But your still much
> better of getting your code fixed properly, and thus pretty much means
> havign your own binary format handler in the kernel that sets up the address
> space in a windows compatible way.

I find randomization interesting and worthy... I would like to see it
integrated into 2.6 although adding a toggle to controli it use could be
desirable.

Another thing I miss is Process ID randomization ala OpenBSD.


