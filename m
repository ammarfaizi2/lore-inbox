Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269657AbUICMM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269657AbUICMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269665AbUICMMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 08:12:45 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:7145 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S269657AbUICMLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 08:11:02 -0400
Date: Fri, 3 Sep 2004 08:15:29 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, takata@linux-m32r.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm3
In-Reply-To: <20040903104239.A3077@infradead.org>
Message-ID: <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2004, Christoph Hellwig wrote:

> On Fri, Sep 03, 2004 at 01:48:11AM -0700, Andrew Morton wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm3/
> >
> > - Added the m32r architecture.  Haven't looked at it yet.
>
> Just from looking at the diffstat and not actual code: the actual code:
>
>  - it adds new drivers under arch/m32r instead of drivers/

Lucky you didn't look ;)

diff -puN /dev/null arch/m32r/drivers/8390.c
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/m32r/drivers/8390.c	Wed Sep  1 15:02:27 2004
@@ -0,0 +1 @@
+#include "../../../drivers/net/8390.c"
diff -puN /dev/null arch/m32r/drivers/8390.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/m32r/drivers/8390.h	Wed Sep  1 15:02:27 2004
@@ -0,0 +1 @@
+#include "../../../drivers/net/8390.h"
diff -puN /dev/null arch/m32r/drivers/cs_internal.h
--- /dev/null	Thu Apr 11 07:25:15 2002
+++ 25-akpm/arch/m32r/drivers/cs_internal.h	Wed Sep  1 15:02:27 2004
@@ -0,0 +1,2 @@
+#include "../../../drivers/pcmcia/cs_internal.h"
+
