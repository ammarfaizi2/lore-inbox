Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268602AbTGJOYP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:24:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbTGJOYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:24:15 -0400
Received: from mail.ithnet.com ([217.64.64.8]:61964 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S268602AbTGJOYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:24:14 -0400
Date: Thu, 10 Jul 2003 16:38:28 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: marcelo@conectiva.com.br, green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030710163828.70eb6587.skraw@ithnet.com>
In-Reply-To: <3F0D761E.2050702@gmx.net>
References: <3F0D761E.2050702@gmx.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 16:20:14 +0200
Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net> wrote:

> Since your hangs are not even traceable with SysRq, please try to boot
> with nmi_watchdog=1 and if that doesn't work (dmesg will complain)
> nmi_watchdog=2. About 15 seconds after the hang your box should print a
> backtrace.

I have currently nmi_watchdog=1 which works (NMI interrupts show up during
normal operation), but there is no backtrace visible or producable during the
freeze, sorry.

-- 
Regards,
Stephan
