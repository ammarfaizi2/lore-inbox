Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270325AbTHLNv2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 09:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270342AbTHLNv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 09:51:28 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:22546 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S270325AbTHLNv1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 09:51:27 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Matthew Peters <matthew@greycloaklabs.ca>
Subject: Re: PROBLEM: kswapd and toshiba libretto 50ct
Date: Tue, 12 Aug 2003 21:50:37 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0308120622050.11089-100000@gateway.greycloaklabs.ca>
In-Reply-To: <Pine.LNX.4.44.0308120622050.11089-100000@gateway.greycloaklabs.ca>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308122150.37582.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 August 2003 21:24, Matthew Peters wrote:
> i have managed to resolder that pin, the kernel detects a clock speed of
> 75mhz again. The 2.4 kernels still don't work though. I've tried using
> both a modular build and one with everything tailored to the system.
>
> I don't have the oops message on hand, but i can get it if required. As
> always, i can't check it on the hardware itself.
>
> Thanks in advance,
>     Matthew

Please check
 - selected processor type: Pentium-Classic
 - compiled with gcc295 or equivalent
 - Leave frame buffers out
 - put only minimal drivers (including serial port and console on serial port)

If it still does not work, please get the oops via serial console, run
it through ksymoops, without it is not much we can do.

Regards
Michael


-- 
Powered by linux-2.6. Compiled with gcc-2.95-3 - mature and rock solid

2.4/2.6 kernel testing: ACPI PCI interrupt routing, PCI IRQ sharing, swsusp
2.6 kernel testing:     PCMCIA yenta_socket, Suspend to RAM with ACPI S1-S3

More info on swsusp: http://sourceforge.net/projects/swsusp/

