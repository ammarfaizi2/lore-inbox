Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262897AbUEKBLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUEKBLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 21:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEKBLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 21:11:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:41128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbUEKBLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 21:11:13 -0400
Date: Mon, 10 May 2004 18:10:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: Wim Coekaerts <wim.coekaerts@oracle.com>
Cc: cw@f00f.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040510181008.1906ea8a.akpm@osdl.org>
In-Reply-To: <20040511002426.GD1105@ca-server1.us.oracle.com>
References: <20040510024506.1a9023b6.akpm@osdl.org>
	<20040510223755.A7773@infradead.org>
	<20040510150203.3257ccac.akpm@osdl.org>
	<20040510231146.GA5168@taniwha.stupidest.org>
	<20040510162818.376b4a55.akpm@osdl.org>
	<20040510233342.GA5614@taniwha.stupidest.org>
	<20040510165132.5107472e.akpm@osdl.org>
	<20040510235312.GA9348@taniwha.stupidest.org>
	<20040510171413.6c1699b8.akpm@osdl.org>
	<20040511002426.GD1105@ca-server1.us.oracle.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim Coekaerts <wim.coekaerts@oracle.com> wrote:
>
> > Migrating away from this will require work from vendors, Oracle, PAM
> > developers, /bin/login and /bin/su developers.  Until that has happened I
> > think we should arrange for vendor kernels and kernel.org kernels to offer
> > the same interfaces.
> 
> We have done the work and are going to be ok going forward to just use
> hugeltbfs directly, just mounting it with right uid,gid. the main issue

err, so why did I just merge the hugetlb_shm_group patch?

