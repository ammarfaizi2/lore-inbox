Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWI2XQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWI2XQm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWI2XQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:16:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932236AbWI2XQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:16:41 -0400
Date: Fri, 29 Sep 2006 16:16:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Ollie Wild" <aaw@google.com>
Cc: "Jeff Dike" <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, dhollis@davehollis.com,
       "Jason Lunz" <lunz@falooley.org>
Subject: Re: [PATCH 2/2] UML - Don't roll my own random MAC generator
Message-Id: <20060929161616.7e47c453.akpm@osdl.org>
In-Reply-To: <65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com>
References: <200609281814.k8SIEsG8005226@ccure.user-mode-linux.org>
	<65dd6fd50609291518s129786fbt1739c80533d1a36@mail.google.com>
	<20060929153853.9bab3ca7.akpm@osdl.org>
	<65dd6fd50609291548x39707437yb7f1308c3397c488@mail.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Sep 2006 15:48:04 -0700
"Ollie Wild" <aaw@google.com> wrote:

> You can use "make ARCH=um SUBARCH=i386 .." to build for i386.

OIC, thanks.

I still get:

arch/um/os-Linux/sys-i386/registers.c: In function 'get_thread_regs':
arch/um/os-Linux/sys-i386/registers.c:137: error: 'JB_PC' undeclared (first use in this function)
arch/um/os-Linux/sys-i386/registers.c:137: error: (Each undeclared identifier is reported only once
arch/um/os-Linux/sys-i386/registers.c:137: error: for each function it appears in.)
arch/um/os-Linux/sys-i386/registers.c:138: error: 'JB_SP' undeclared (first use in this function)
arch/um/os-Linux/sys-i386/registers.c:139: error: 'JB_BP' undeclared (first use in this function)

