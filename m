Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264471AbUAOBh3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAOBh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:29 -0500
Received: from dp.samba.org ([66.70.73.150]:19335 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264471AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
Date: Thu, 15 Jan 2004 11:35:25 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, jh@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add noinline attribute
Message-Id: <20040115113525.6de1cbc1.rusty@rustcorp.com.au>
In-Reply-To: <20040114083114.GA1784@averell>
References: <20040114083114.GA1784@averell>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 09:31:14 +0100
Andi Kleen <ak@muc.de> wrote:
> do_test_wp_bit cannot be inlined, otherwise the kernel doesn't boot
> because the exception tables get reordered. 

Maybe you should sort the exception table as PPC does.  See FIXME
in i386/kernel/module.c too.

Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
