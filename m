Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWGJFCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWGJFCF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 01:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWGJFCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 01:02:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751311AbWGJFCE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 01:02:04 -0400
Date: Sun, 9 Jul 2006 22:01:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: reuben-lkml@reub.net, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, greg@kroah.com
Subject: Re: 2.6.18-rc1-mm1
Message-Id: <20060709220154.52cff4fa.akpm@osdl.org>
In-Reply-To: <20060709215649.33306c7c.rdunlap@xenotime.net>
References: <20060709021106.9310d4d1.akpm@osdl.org>
	<44B0E6E6.6070904@reub.net>
	<20060709215649.33306c7c.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jul 2006 21:56:49 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> Has this already been addressed?
> 
> 
> [   82.315906] ----------- [cut here ] --------- [please bite here ] ---------
> [   82.329754] Kernel BUG at mm/page_alloc.c:252

CONFIG_DEBUG_VM=n should make that go away.
