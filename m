Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269291AbTGJO3y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269292AbTGJO3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 10:29:54 -0400
Received: from pop.gmx.de ([213.165.64.20]:36512 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269291AbTGJO3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 10:29:51 -0400
Message-ID: <3F0D7BCC.7070607@gmx.net>
Date: Thu, 10 Jul 2003 16:44:28 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: de, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: marcelo@conectiva.com.br, green@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
References: <3F0D761E.2050702@gmx.net> <20030710163828.70eb6587.skraw@ithnet.com>
In-Reply-To: <20030710163828.70eb6587.skraw@ithnet.com>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
> On Thu, 10 Jul 2003 16:20:14 +0200
> Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net> wrote:
> 
> 
>>Since your hangs are not even traceable with SysRq, please try to boot
>>with nmi_watchdog=1 and if that doesn't work (dmesg will complain)
>>nmi_watchdog=2. About 15 seconds after the hang your box should print a
>>backtrace.
> 
> 
> I have currently nmi_watchdog=1 which works (NMI interrupts show up during
> normal operation), but there is no backtrace visible or producable during the
> freeze, sorry.

How is that possible? If the NMI watchdog works but doesn't fire, the
lockup should respond to SysRq-T. Could you please try SysRq-T *before*
the hang just to verify that it would work?


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/

