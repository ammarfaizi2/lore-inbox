Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTKOJyz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 04:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbTKOJyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 04:54:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:6113 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261598AbTKOJyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 04:54:54 -0500
Date: Sat, 15 Nov 2003 01:59:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Ben Hoskings" <ben@jeeves.bpa.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 yenta_socket eats kernel time on Toshiba Laptop
Message-Id: <20031115015927.4e31e6ee.akpm@osdl.org>
In-Reply-To: <43376.138.130.214.20.1068871325.squirrel@jeeves.home.house>
References: <43376.138.130.214.20.1068871325.squirrel@jeeves.home.house>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Ben Hoskings" <ben@jeeves.bpa.nu> wrote:
>
> I've got a Toshiba Satellite Pro 4300 (PIII-750 on an Intel 440BX
>  chipset). Modprobing yenta_socket under 2.6.0 (I've tried test6 to test9
>  inclusive) causes the system to appear to lock up.
>  Once I managed to change consoles and run top (each keystroke took a good
>  20 seconds to echo), which showed that the kernel was using 100% CPU time.
> 
>  Attepting a modprobe on any of the other PCMCIA bus drivers gives a
>  'device not found' error.
> 
>  Under 2.4, the PCMCIA bus uses the i82365 module, which works perfectly.
>  Under 2.6, it appears that the related driver has been moved to the
>  yenta_socket module (It's a ToPIC100 Controller; see dmesg below).

Have you tried disabling i82365 in kernel config?
