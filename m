Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269464AbSIRWcO>; Wed, 18 Sep 2002 18:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269466AbSIRWcN>; Wed, 18 Sep 2002 18:32:13 -0400
Received: from dp.samba.org ([66.70.73.150]:26812 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S269464AbSIRWcN>;
	Wed, 18 Sep 2002 18:32:13 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] In-kernel module loader 5/7 
In-reply-to: Your message of "Wed, 18 Sep 2002 09:43:10 +0200."
             <20020918074310.GA1539@werewolf.able.es> 
Date: Thu, 19 Sep 2002 08:07:32 +1000
Message-Id: <20020918223716.6343E2C091@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020918074310.GA1539@werewolf.able.es> you write:
> Would not be worthy to do something like
> 
> #define MODULE_INIT_DEFAULT \
> static int init(void) { return o;} \
> module_init(init)
> ...
> 
> so you just can add:
> 
> MODULE_INIT_DEFAULT;
> MODULE_EXIT_DEFAULT;

Hmmm... I didn't do that because I want people to *think* about init
and exit issues, and because most modules *do* need some
initialization.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
