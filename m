Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUHaBTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUHaBTx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUHaBTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:19:53 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:47528 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266127AbUHaBTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:19:52 -0400
Message-ID: <9e473391040830181941d62ed0@mail.gmail.com>
Date: Mon, 30 Aug 2004 21:19:52 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: "biscani@pd.astro.it" <biscani@pd.astro.it>
Subject: Re: System freeze: __iounmap: bad address dfd00000
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
In-Reply-To: <1093735779.41311563b892b@webmail.pd.astro.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1093735779.41311563b892b@webmail.pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2004 01:29:39 +0200, biscani@pd.astro.it
<biscani@pd.astro.it> wrote:
> Aug 28 18:43:00 kurtz __iounmap: bad address dfd00000

That address looks like it might be a video card. cat /proc/iomem or
lspci -v will tell you the owner and give you a clue where to look for
problems.
