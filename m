Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbTH0MDn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 08:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbTH0MDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 08:03:43 -0400
Received: from inway106.cdi.cz ([213.151.81.106]:38613 "EHLO luxik.cdi.cz")
	by vger.kernel.org with ESMTP id S263308AbTH0MDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 08:03:42 -0400
Date: Wed, 27 Aug 2003 14:03:22 +0200 (CEST)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.21 on SMP has extra slow context switch
Message-ID: <Pine.LNX.4.33.0308271358200.529-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I upgraded one SMP box (Soyo MB, 2x PII/350, 500MB) from
2.4.8 (really) to 2.4.21 last week. Users start to complaint
that it is slow.
I run lmbench's context switch measurer and it's result is:
"size=0k ovr=5.41
2 169.26
3 111.28
4 83.99

While on very similar UP system (the same CPU & kernel) it is:
"size=0k ovr=3.50
2 1.80
3 2.08
4 2.89

Have someone even idea what is going on ? The systems seems to be
fairly stable but slooow.
I plan to reboot with single CPU at evening and/or upgrade to .22,
but the numbers above are weird.

thanks,
-------------------------------
    Martin Devera aka devik
Linux kernel QoS/HTB maintainer
  http://luxik.cdi.cz/~devik/

