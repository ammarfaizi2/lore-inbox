Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbTIVXBP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbTIVXBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:01:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:33509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261164AbTIVXBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:01:13 -0400
Date: Mon, 22 Sep 2003 15:41:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm4: wanxl doesn't compile with gcc 2.95
Message-Id: <20030922154132.2d134e6f.akpm@osdl.org>
In-Reply-To: <m3fzioigxw.fsf@defiant.pm.waw.pl>
References: <20030922013548.6e5a5dcf.akpm@osdl.org>
	<20030922191049.GC6325@fs.tum.de>
	<m3fzioigxw.fsf@defiant.pm.waw.pl>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@pm.waw.pl> wrote:
>
> +		       " at 0x%LX!\n", card_name(pdev), (u64)addr);

This should be "unsigned long long", not u64.  That is what "%L" means,
after all.

