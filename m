Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWHYGVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWHYGVN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964823AbWHYGVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:21:13 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52892 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964810AbWHYGVK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:21:10 -0400
Date: Thu, 24 Aug 2006 23:20:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>, Zach Brown <zach.brown@oracle.com>
Subject: Re: [take13 1/3] kevent: Core files.
Message-Id: <20060824232024.0d230823.akpm@osdl.org>
In-Reply-To: <20060825054815.GC16504@2ka.mipt.ru>
References: <11563322941645@2ka.mipt.ru>
	<11563322971212@2ka.mipt.ru>
	<20060824200322.GA19533@infradead.org>
	<20060825054815.GC16504@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Aug 2006 09:48:15 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> kmalloc is really slow actually - it always shows somewhere on top 
> in profiles and brings noticeble overhead

It shouldn't.  Please describe the workload and send the profiles.
