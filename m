Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270699AbTGNRSt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 13:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTGNRQQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 13:16:16 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:29888 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S270697AbTGNRPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 13:15:35 -0400
X-AuthUser: davidel@xmailserver.org
Date: Mon, 14 Jul 2003 10:22:59 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: Mike Galbraith <efault@gmx.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy    ...
In-Reply-To: <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
Message-ID: <Pine.LNX.4.55.0307141015010.4828@bigblue.dev.mcafeelabs.com>
References: <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net>
 <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net> <5.2.1.1.2.20030714063443.01bcc5f0@pop.gmx.net>
 <5.2.1.1.2.20030714100438.01be5008@pop.gmx.net> <5.2.1.1.2.20030714174719.01bce3f8@pop.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jul 2003, Mike Galbraith wrote:

> Yes, and it worked fine.  No cpu load I tossed at it caused a skip.

I tried yesterday a thud.c load and it did not get a single skip here
either. It is interesting what thud.c can do to latency (let's not talk
about irman because things get really nasty). With a simple `thud 5` the
latency rised to more then one full second, as you can see by the graphs
inside the SOFTRR page. No buffer size can cope with that.



- Davide

