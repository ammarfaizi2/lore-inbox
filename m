Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbTDKRlL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 13:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTDKRlL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 13:41:11 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261242AbTDKRlK (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 13:41:10 -0400
Date: Fri, 11 Apr 2003 10:51:58 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: devilkin-lkml@blindguardian.org, portnoy@tellink.net,
       root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-Id: <20030411105158.2d9b728e.rddunlap@osdl.org>
In-Reply-To: <20030411054932.GC10992@conectiva.com.br>
References: <3E93A958.80107@si.rr.com>
	<Pine.LNX.4.53.0304101638010.4978@chaos>
	<Pine.LNX.4.53.0304101903280.19136@cerberus.oppresses.us>
	<200304110739.41947.devilkin-lkml@blindguardian.org>
	<20030411054932.GC10992@conectiva.com.br>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Apr 2003 02:49:32 -0300 Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

| Em Fri, Apr 11, 2003 at 07:39:35AM +0200, DevilKin escreveu:
| > Why not turn it into a kernel flag that you can set at bootup through LILO or 
| > some other obscure boot manager? Then you could boot linux like this:
| > 
| > linux dmesg=verbose
| > 
| > and
| > 
| > linux dmesg=quiet
| 
| Have you ever tried passing 'quiet' as a cmd line parameter to the kernel
| in the bootloader? If not please try.
| 
| Try also 'debug'.

I use 'debug' all the time, but then some init script comes along and
changes the loglevel setting to something < debug.  Ick.


--
~Randy   ['tangent' is not a verb...unless you believe that
          "in English any noun can be verbed."]
