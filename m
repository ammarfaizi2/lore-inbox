Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265568AbUATQ7t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 11:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbUATQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 11:59:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:20656 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265568AbUATQ7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 11:59:47 -0500
Date: Tue, 20 Jan 2004 09:00:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, paulus@samba.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
Message-Id: <20040120090004.48995f2a.akpm@osdl.org>
In-Reply-To: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@trained-monkey.org> wrote:
>
> The new sort_extable and shares search_extable code doesn't work on
>  ia64.

hm, OK.  It would be nice if ia64 could use the generic code at some stage,
of course.

One wonders why the linker dragged lib/extable.c in at all.  Or does it fail at
compile time?


