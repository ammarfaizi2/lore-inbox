Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751040AbVKRByK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbVKRByK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbVKRByK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:54:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13455 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750970AbVKRByH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:54:07 -0500
Date: Thu, 17 Nov 2005 17:53:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1-mm1
Message-Id: <20051117175343.2b2c0a9c.akpm@osdl.org>
In-Reply-To: <437D3205.3080506@student.ltu.se>
References: <20051117111807.6d4b0535.akpm@osdl.org>
	<437D3205.3080506@student.ltu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc1/2.6.15-rc1-mm1
>  >  
>  >
>  Got a compiler-error:
> 
>    CC      drivers/serial/jsm/jsm_tty.o
>  drivers/serial/jsm/jsm_tty.c: In function `jsm_input':
>  drivers/serial/jsm/jsm_tty.c:592: error: structure has no member named `flip'
>  drivers/serial/jsm/jsm_tty.c:619: error: structure has no member named `flip'
>  drivers/serial/jsm/jsm_tty.c:620: error: structure has no member named `flip'

Yes, sorry, JSM is known-to-be-bust-in-mm.  The maintainers are working
(slowly) on fixing it up.

