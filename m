Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269313AbTGJO6R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269318AbTGJO6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:58:16 -0400
Received: from mail.ithnet.com ([217.64.64.8]:10768 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S269313AbTGJO6M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:58:12 -0400
Date: Thu, 10 Jul 2003 17:12:31 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: marcelo@conectiva.com.br, green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030710171231.01df358e.skraw@ithnet.com>
In-Reply-To: <3F0D7BCC.7070607@gmx.net>
References: <3F0D761E.2050702@gmx.net>
	<20030710163828.70eb6587.skraw@ithnet.com>
	<3F0D7BCC.7070607@gmx.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 16:44:28 +0200
Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net> wrote:

> > I have currently nmi_watchdog=1 which works (NMI interrupts show up during
> > normal operation), but there is no backtrace visible or producable during
> > the freeze, sorry.
> 
> How is that possible? If the NMI watchdog works but doesn't fire, the
> lockup should respond to SysRq-T. Could you please try SysRq-T *before*
> the hang just to verify that it would work?

Well, the thing I don't really understand about SysRq-X is that the output is
visible by dmesg-command, but I cannot see anything on the console (single user
tested). This means it may well work in the hang-case, but as I cannot execute
dmesg I will never see it...

Regards,
Stephan
