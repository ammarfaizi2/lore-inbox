Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUDPUEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 16:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUDPUEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 16:04:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:36548 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263629AbUDPUDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 16:03:52 -0400
Date: Fri, 16 Apr 2004 13:06:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deinline put_page if CONFIG_HUGETLB_PAGE=y
Message-Id: <20040416130604.65b88d5c.akpm@osdl.org>
In-Reply-To: <200404162254.46533.vda@port.imtp.ilyichevsk.odessa.ua>
References: <200404162230.40530.vda@port.imtp.ilyichevsk.odessa.ua>
	<200404162254.46533.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> This patch deinlines put_page if CONFIG_HUGETLB_PAGE=y.

You'll be impressed to hear that your patch was merged two days before you
wrote it ;)

(You're missing an EXPORT_SYMBOL btw)
