Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbUAIDTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 22:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264976AbUAIDTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 22:19:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:41679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264942AbUAIDTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 22:19:51 -0500
Date: Thu, 8 Jan 2004 19:20:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, ericy@cais.com
Subject: Re: [PATCH][RFC] invalid ELF binaries can execute - better sanity
 checking
Message-Id: <20040108192021.6c2aea60.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401090236390.11276@jju_lnx.backbone.dif.dk>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl@dif.dk> wrote:
>
> The current Linux kernel does only very basic sanity checking on ELF
>  binaries.

I've always had little confidence in the elf loader.  The problem is
complex, the code quality is not high and the consequences of an error are
severe.

I guess others realise this, and the bad guys have probably already
"audited" the code for us, but still.

I'll merge your additional checks for testing and would encourage you to
keep looking at the problem, thanks.


