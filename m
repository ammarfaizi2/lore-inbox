Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264287AbUD0TC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264287AbUD0TC0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 15:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbUD0TCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 15:02:08 -0400
Received: from cyberhostplus.biz ([209.124.87.2]:61108 "EHLO
	server.cyberhostplus.biz") by vger.kernel.org with ESMTP
	id S264287AbUD0TBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 15:01:52 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Tue, 27 Apr 2004 14:03:01 -0500
Message-ID: <000001c42c8a$485cd950$8119fea9@pluto>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.cyberhostplus.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tuxsoft.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of printing module taint messages to the screen, why couldn't
they just
be written to syslog?  Then it wouldn't matter if there were several
taint
messages.  For example, I know my nVidia driver taints the kernel, I
don't need
to see that message over and over again.

Marc Boucher <marc () linuxant ! com> wrote:

> Actually, we also have no desire nor purpose to prevent tainting. The
purpose
> of the workaround is to avoid repetitive warning messages generated
when
> multiple modules belonging to a single logical "driver"  are loaded
(even when
> a module is only probed but not used due to the hardware not being
present).
> Although the issue may sound trivial/harmless to people on the lkml,
it was a
> frequent cause of confusion for the average person.


