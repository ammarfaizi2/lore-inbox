Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267654AbSKTHil>; Wed, 20 Nov 2002 02:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267656AbSKTHil>; Wed, 20 Nov 2002 02:38:41 -0500
Received: from dp.samba.org ([66.70.73.150]:52193 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267654AbSKTHij>;
	Wed, 20 Nov 2002 02:38:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Juan M. de la Torre" <jmtorre@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sys_init_module refuses to load module without init code/data sections 
In-reply-to: Your message of "Tue, 19 Nov 2002 20:38:57 BST."
             <20021119193857.GA406@apocalipsis> 
Date: Wed, 20 Nov 2002 18:35:36 +1100
Message-Id: <20021120074545.285F02C05C@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20021119193857.GA406@apocalipsis> you write:
> 
>   load_module() stores in mod->init_size the size of init data and init
>  code sections, and later allocs (using module_alloc()) mod->init_size
>  bytes. 

Yep, fix already sent to Linus.

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
