Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUHWVuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUHWVuR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 17:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUHWVry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 17:47:54 -0400
Received: from mail.dif.dk ([193.138.115.101]:8942 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267737AbUHWVo3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 17:44:29 -0400
Date: Mon, 23 Aug 2004 23:50:03 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Shouldn't kconfig defaults match recommendations in help text?   
Message-ID: <Pine.LNX.4.61.0408232347380.3767@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

First of all; I'm sorry if this hits the list twice, my original mail 
seems to have gone missing somehow so this is a resend.


I've been wondering about situations like this for a while :


[quote]

The processor's performance-monitoring counters are special-purpose
global registers. This option adds support for virtual per-process
performance-monitoring counters which only run when the process
to which they belong is executing. This improves the accuracy of
performance measurements by reducing "noise" from other processes.

Say Y.

  Virtual performance counters support (PERFCTR_VIRTUAL) [N/y/?] (NEW)

[/quote]


I just picked the above randomly, there are several other cases like it.

The comment clearly makes a recommendation that the user enables (in this 
case) the option, yet the default is the exact opposite. What is the point 
in that?
I don't see anything but confusion amongst users as the result of such 
inconsistency.

Would patches to change default configuration choices to match the 
recommendation given in the help text (if any) be acceptable? If not I'd 
be interrested in the reasons why not.

If such patches are acceptable/wanted I'll be happy to supply them.


--
Jesper Juhl <juhl-lkml@dif.dk>

