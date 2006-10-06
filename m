Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWJFBAj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWJFBAj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 21:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWJFBAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 21:00:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15844 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932545AbWJFBAi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 21:00:38 -0400
Date: Thu, 5 Oct 2006 18:00:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 04/14] uml: readd forgot prototype
Message-Id: <20061005180035.90c6937e.akpm@osdl.org>
In-Reply-To: <20061005213846.17268.31893.stgit@memento.home.lan>
References: <20061005213212.17268.7409.stgit@memento.home.lan>
	<20061005213846.17268.31893.stgit@memento.home.lan>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Oct 2006 23:38:46 +0200
"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:

> --- a/arch/um/include/os.h
> +++ b/arch/um/include/os.h
> @@ -201,6 +201,7 @@ extern int os_getpgrp(void);
>  
>  #ifdef UML_CONFIG_MODE_TT
>  extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
> +extern void stop(void);

You have a global function called "stop"?

Good luck with that...

