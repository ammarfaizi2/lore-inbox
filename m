Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130510AbRBUAvh>; Tue, 20 Feb 2001 19:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130985AbRBUAv0>; Tue, 20 Feb 2001 19:51:26 -0500
Received: from jalon.able.es ([212.97.163.2]:25587 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130510AbRBUAvR>;
	Tue, 20 Feb 2001 19:51:17 -0500
Date: Wed, 21 Feb 2001 01:50:59 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Paul Gortmaker <p_gortmaker@yahoo.com>
Cc: linux-kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Better BUG() macro - take 2
Message-ID: <20010221015059.A18619@werewolf.able.es>
In-Reply-To: <3A924B83.43133ED2@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A924B83.43133ED2@yahoo.com>; from p_gortmaker@yahoo.com on Tue, Feb 20, 2001 at 11:48:35 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.20 Paul Gortmaker wrote:
>  
> +#ifdef CONFIG_DEBUG_ERRORS
> +const char *kernel_bug = "kernel BUG at %s: line %d!\n";
> +#endif
> 
..
>  EXPORT_SYMBOL(daemonize);
> +EXPORT_SYMBOL(kernel_bug);
>  

Should also be #ifdef'd.
 
-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac19 #1 SMP Mon Feb 19 21:52:31 CET 2001 i686

