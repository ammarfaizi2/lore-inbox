Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269884AbTGOXji (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 19:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269889AbTGOXji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 19:39:38 -0400
Received: from adsl-216-103-111-100.dsl.snfc21.pacbell.net ([216.103.111.100]:26546
	"EHLO www.piet.net") by vger.kernel.org with ESMTP id S269884AbTGOXjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 19:39:36 -0400
Subject: Re: modules problems with 2.6.0 (module-init-tools-0.9.12)
From: Piet Delaney <piet@www.piet.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Fernando Sanchez <fsanchez@mail.usfq.edu.ec>, linux-kernel@vger.kernel.org
In-Reply-To: <20030715152257.614d628b.rddunlap@osdl.org>
References: <3F147B8F.5000103@mail.usfq.edu.ec> 
	<20030715152257.614d628b.rddunlap@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 15 Jul 2003 16:53:12 -0700
Message-Id: <1058313192.21300.988.camel@www.piet.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-07-15 at 15:22, Randy.Dunlap wrote:

I heard that if you install the new module-init-tools package in
/sbin that you would be able to boot old kernels. Is that true?

I installed the module-init-tools package and it went to /usr/local.
First I changed the kernel Makefile to point to /usr/local then
I had module problems and tried copying the cmds to /sbin and 
renamed the the old commands like implied in the script:

 		generate-modprobe.conf

Yesterday I heard I better move them back or I won't be able
to boot my old kernels. It's hard to believe that these tools
aren't backward compatible.

Moving the module-init-tools to /sbin didn't help my problem;
is it necessary/helpful. Perhaps they are only needed for 
building the new kernels.

-piet


> On Tue, 15 Jul 2003 17:09:19 -0500 Fernando Sanchez <fsanchez@mail.usfq.edu.ec> wrote:
> 
> | Hi,
> | 
> | I've been trying to get 2.6.0 to work, I've enabled modules support, but 
> | I get this error on my logs:
> | 
> | Jul 15 15:38:36 Darakemba kernel: No module symbols loaded - kernel 
> | modules not enabled.
> | 
> | Is there any thing like a new modutils that should be used with 2.6.x 
> | family?
> 
> Yes, they are at
>   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> 
> Also, a summary of 2.5/2.6 changes is very worthwhile reading.  See:
>   http://www.codemonkey.org.uk/post-halloween-2.5.txt
> for which config options that you really need to enable.
> 
> | The kernel does boot, but not having any modules I can't do much, and 
> | also, I never get to really see the messages on screen, on logs I have 
> | this line:
> | 
> | Jul 15 15:38:36 Darakemba kernel: Video mode to be used for restore is ffff
> | 
> | What does it mean?
> 
> Dunno.  Anyone?
> 
> | I disabled all the framebuffer things so I can just use vga, on lilo, 
> | vga mode is set to normal, but still can't see anything.
> 
> 
> --
> ~Randy
> | http://developer.osdl.org/rddunlap/ | http://www.xenotime.net/linux/ |
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
piet@www.piet.net

