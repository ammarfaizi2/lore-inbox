Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTK3NGi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 08:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264901AbTK3NGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 08:06:38 -0500
Received: from tristate.vision.ee ([194.204.30.144]:11169 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S264898AbTK3NGh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 08:06:37 -0500
From: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@city.ee>
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
To: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 15:06:31 +0200
References: <WSA7.6D.39@gated-at.bofh.it> <WTYM.3ua.7@gated-at.bofh.it> <WVoa.73O.17@gated-at.bofh.it>
User-Agent: KNode/0.7.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20031130130631.DF0EE9F60@xs.dev>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Julien Oster wrote:

> No, it's most evidently a mainboard problem, as everybody using an
> ASUS A7N8X (Deluxe) reported so far that the mainboard will lock up
> completely unless you turn of ACPI, APIC and local APIC. There is no
> other possibility to work this lockup madness around, as many users of
> that mainboard including me really tried *everything*.
> 
> We know that other NForce2 Mainboards don't have this kind of problem,
> but sadly that isn't of any help whatsoever for us A7N8X users.

I can't agree. I've had experiences with two Epox mobos - 8RDA+ running
2.6-test kernels and 8RDA3+ running 2.4.22 kernel.

Both of them locked completely up sometimes (that was after week or so
without reboot). It seems that compiling Local-APIC out of kernel has
stopped this behaviour. It's been about a month without lockups for 2.4
machine. 2.6 hasn't locked up either but it gets a new kernel and a reboot
every week anyway.

Actually the machine with 2.4 kernel run initially 1.5 months without a
glitch (and Local-APIC compiled in) before it started to lock up weekly. I
don't know why. Anyway as I said disabling Local-APIC has stopped all those
lockups.

Lenar
