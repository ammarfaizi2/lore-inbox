Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbUATCMA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 21:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265303AbUATCJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 21:09:25 -0500
Received: from dp.samba.org ([66.70.73.150]:21414 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265251AbUATCHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 21:07:15 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Modernize i386 string.h 
In-reply-to: Your message of "Sun, 18 Jan 2004 21:09:19 BST."
             <20040118200919.GA26573@averell> 
Date: Tue, 20 Jan 2004 13:04:57 +1100
Message-Id: <20040120020710.9C59B2C2C8@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040118200919.GA26573@averell> you write:
> +EXPORT_SYMBOL_NOVERS_NOVERS(memmove);

FYI: this has no meaningful semantic in 2.6 (we don't mangle symbols,
but include the version in a separate section anyway).

Please use EXPORT_SYMBOL() everywhere in new code.

Thanks!
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
