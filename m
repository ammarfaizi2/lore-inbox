Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbUEAWvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbUEAWvf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 18:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUEAWvf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 18:51:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:59534 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262488AbUEAWve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 18:51:34 -0400
Date: Sat, 1 May 2004 15:51:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org, kaos@sgi.com
Subject: Re: [PATCH][2.6-mm] Allow i386 to reenable interrupts on lock
 contention
Message-Id: <20040501155116.6ac6e253.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405011750070.2332@montezuma.fsmlabs.com>
References: <2015.1083331968@ocs3.ocs.com.au>
	<Pine.LNX.4.58.0405010628030.2332@montezuma.fsmlabs.com>
	<20040501143955.10d1cea1.akpm@osdl.org>
	<Pine.LNX.4.58.0405011750070.2332@montezuma.fsmlabs.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> wrote:
>
> On Sat, 1 May 2004, Andrew Morton wrote:
> 
>  > Could we move all the irq-handling stuff into the out-of-line section, to
>  > keep the fast-path cache footprint smaller?
> 
>  Of course, oversight on my part. Done and restested.

Thanks.  Would be nice to find some test which showed improved throughput
from this ;)
