Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262363AbTEUXho (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbTEUXhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:37:43 -0400
Received: from [212.97.163.22] ([212.97.163.22]:65509 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262363AbTEUXhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:37:43 -0400
Date: Thu, 22 May 2003 01:50:33 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: David Woodhouse <dwmw2@infradead.org>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shared crc32 for 2.4.
Message-ID: <20030521235033.GA2470@werewolf.able.es>
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1053193432.9218.13.camel@imladris.demon.co.uk>; from dwmw2@infradead.org on Sat, May 17, 2003 at 19:43:53 +0200
X-Mailer: Balsa 2.0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 05.17, David Woodhouse wrote:
> This has been needed for a long time... please pull from
> master.kernel.org:/home/dwmw2/BK/crc32-2.4 or apply the GNU patch below.
> 
> I can resend for 2.4.22-pre1 if you prefer, but it's been working in 2.5
> and in various other 2.4 trees for a while now so I'm sending it now
> anyway.
> 

This works if crc32.o is compiled as a module, but does not work if it is
built into the kernel. For example, crc32_le symbol does not appear
in System.map nor vmlinux.
For me, it failed with 8390.o ans 8139too.o. But just because they are the
only drivers needing crc32 that I build.

TIA

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.21-rc2-jam1 (gcc 3.2.3 (Mandrake Linux 9.2 3.2.3-1mdk))
