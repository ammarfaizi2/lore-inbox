Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbUK2VZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbUK2VZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 16:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbUK2VZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 16:25:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:56704 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261807AbUK2VZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 16:25:20 -0500
Date: Mon, 29 Nov 2004 13:29:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Darren Hart <dvhltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, piggin@cyberone.com.au, mingo@elte.hu
Subject: Re: scheduler BUGON lifespan
Message-Id: <20041129132931.7f87742b.akpm@osdl.org>
In-Reply-To: <1101762694.29380.23.camel@farah.beaverton.ibm.com>
References: <1101762694.29380.23.camel@farah.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Darren Hart <dvhltc@us.ibm.com> wrote:
>
> How long should this BUGON remain in the kernel?

Until someone thinks to remove it, it seems.  There is no established
protocol or period.  Often someone will say "hey, this is silly" and will
remove it - usually as part of some wider work.

If you think a BUG or BUG_ON doesn't need to be there any more, feel free
to send a patch..

