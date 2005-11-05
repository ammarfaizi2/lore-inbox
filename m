Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVKERq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVKERq5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 12:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbVKERq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 12:46:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42908 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932149AbVKERqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 12:46:55 -0500
Date: Sat, 5 Nov 2005 09:46:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Richard Knutsson <ricknu-0@student.ltu.se>
Cc: ashutosh.lkml@gmail.com, netdev@vger.kernel.org, davej@suse.de,
       acme@conectiva.com.br, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH]dgrs - Fixes Warnings when CONFIG_ISA and CONFIG_PCI are
 not enabled
Message-Id: <20051105094637.2facb16e.akpm@osdl.org>
In-Reply-To: <436C9D73.5030506@student.ltu.se>
References: <81083a450511012314q4ec69927gfa60cb19ba8f437a@mail.gmail.com>
	<4368878D.4040406@student.ltu.se>
	<c216304e0511020516o5cfcd0b9u96a3220bf2694928@mail.gmail.com>
	<436927CA.3090105@student.ltu.se>
	<20051104182537.741be3d9.akpm@osdl.org>
	<20051104183043.27a2229c.akpm@osdl.org>
	<436C6F02.90904@student.ltu.se>
	<20051105004609.0f04481c.akpm@osdl.org>
	<436C9D73.5030506@student.ltu.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Knutsson <ricknu-0@student.ltu.se> wrote:
>
>  BTW, can anyone ack or is that up to the maintainers?

It's useful info - it shows that someone else took the time to revie the
code.

>  BTW #2, why not remove #ifdef CONFIG_PCI on dgrs_cleanup_module() at the 
>  same time? Or maybe that should be in a "remove config_pci"-patch...

yup.  There are lots of opportunities for that, I bet.
