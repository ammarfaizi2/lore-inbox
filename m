Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264289AbTDPSQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 14:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264330AbTDPSQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 14:16:15 -0400
Received: from 213-4-13-153.uc.nombres.ttd.es ([213.4.13.153]:29189 "HELO
	small.felipe-alfaro.com") by vger.kernel.org with SMTP
	id S264289AbTDPSQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 14:16:14 -0400
Subject: Re: rh9 and 2.5 kernel difficulties
From: Felipe Alfaro Solana <yo@felipe-alfaro.com>
To: Dave Mehler <dmehler26@woh.rr.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <003b01c3043c$0876ad10$0200a8c0@satellite>
References: <003b01c3043c$0876ad10$0200a8c0@satellite>
Content-Type: text/plain
Organization: 
Message-Id: <1050517678.598.10.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 16 Apr 2003 20:27:58 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 19:17, Dave Mehler wrote:
> Hello,
>     I've successfully compiled/installed a 2.5.67 kernel on rh9, and the
> modules. The problem is when i boot it grub just hangs, i'm assuming i've
> compiled everything right, i've read about the keyboard/mouse/monitor
> issues, but then i got a reference to something to do with modules and
> compatibility with 2.4, I did not however find this and i'm wondering if
> that is my problem. Can anyone give me a pointer to all that i need for
> this? My system has an A7A266 motherboard, and i'm getting an error about
> i8253 count too high! error message and it was suggested that a 2.5 kernel
> would resolve this.

Well, I assume that when you say "it hangs" you mean "it displays,
Uncompressing linux kernel... OK, booting" and then it stays there
forever.

Have you tried with the latest BitKeeper (-bk) snapshot available from
http://www.kernel.org? Also, try disabling ACPI and APIC to see if it
helps..
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

