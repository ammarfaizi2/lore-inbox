Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266622AbUHXChf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUHXChf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 22:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266491AbUHXCd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 22:33:57 -0400
Received: from mail.dif.dk ([193.138.115.101]:41183 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S267348AbUHWSvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:51:53 -0400
Date: Mon, 23 Aug 2004 20:57:27 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Shouldn't kconfig defaults match recommendations in help text?
Message-ID: <Pine.LNX.4.61.0408232050450.3767@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I've been wondering about situations like this for a while :


<quote>

The processor's performance-monitoring counters are special-purpose
global registers. This option adds support for virtual per-process
performance-monitoring counters which only run when the process
to which they belong is executing. This improves the accuracy of
performance measurements by reducing "noise" from other processes.

Say Y.

  Virtual performance counters support (PERFCTR_VIRTUAL) [N/y/?] (NEW)

</quote>


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
