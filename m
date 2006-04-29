Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWD2Cth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWD2Cth (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWD2Cth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:49:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751471AbWD2Ctg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:49:36 -0400
Date: Fri, 28 Apr 2006 19:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] NUMA support for spufs
Message-Id: <20060428194746.531b1a4f.akpm@osdl.org>
In-Reply-To: <17490.53283.417700.559725@cargo.ozlabs.ibm.com>
References: <20060429011827.502138000@localhost.localdomain>
	<17490.53283.417700.559725@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
>
> Arnd Bergmann writes:
> 
> > The current version of spufs breaks upon boot when NUMA support is enabled.
> > I'd like to fix that before 2.6.17 so we can use the same kernel image
> > on Cell that we use on other powerpc systems using NUMA.
> 
> Andrew,
> 
> If 2/4 of this series looks OK to you to go into 2.6.17,

OK by me.  1/4 touches __add_pages(), which it undergoing quite a bit of
churn at present, but we'll work it out.

> let me know
> and I'll push the others to Linus (or you can if you prefer).

I'll queue all four for the next batch (within the next 48 hours).  If you
merge them first then no probs.

