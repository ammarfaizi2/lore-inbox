Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264445AbUAOBjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264547AbUAOBho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:44 -0500
Received: from dp.samba.org ([66.70.73.150]:24455 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264575AbUAOBh1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:27 -0500
Date: Thu, 15 Jan 2004 11:40:11 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jh@suse.cz
Subject: Re: [PATCH] Add CONFIG for -mregparm=3
Message-Id: <20040115114011.204da83f.rusty@rustcorp.com.au>
In-Reply-To: <20040114090603.GA1935@averell>
References: <20040114090603.GA1935@averell>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jan 2004 10:06:03 +0100
Andi Kleen <ak@muc.de> wrote:
> I didn't make it the default because it will break all binary only
> modules (although they can be fixed by adding a wrapper that 
> calls them with "asmlinkage"). Actually it may be a good idea to 
> make this default with 2.7.1 or somesuch.

Who cares.  Anyway, if kept as a config option, this should probably be
added to MODULE_ARCH_VERMAGIC in include/asm-i386/module.h.

Thanks,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
