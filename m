Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271379AbTHLSqk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 14:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271381AbTHLSqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 14:46:40 -0400
Received: from main.gmane.org ([80.91.224.249]:20903 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S271379AbTHLSqi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 14:46:38 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jens Benecke <usenet@jensbenecke.de>
Subject: 2.4.22rc2 repeated crashes / Oops / IRQ problems
Date: Tue, 12 Aug 2003 20:46:42 +0200
Message-ID: <bhbcma$eh$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart3050886.JJdo7gqvQS"
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: KNode/0.7.6
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3050886.JJdo7gqvQS
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I posted this earlier but it didn't get accepted (it seems). So I'll tr=
y
again. I tried "noapic" which results in "CPU0 APIC error (40)" or
something like that.

.config is attached, the rest is below. Please advise me on how to corn=
er
this problem.



Marcelo Tosatti wrote:

> Here goes release candidate 2.
> It contains yet another bunch of important fixes, detailed below.
> Nice weekend for all of you!

I'm having problems.  had them with -pre10 as well, posted here, but th=
ey
somehow didn't appear in the list.

Here's the short story: No network (3c509) because the card gets IRQ 22=
 (or
something) and doesn't like it, no USB, no firewire, no X11 (yeah, shou=
ld
have recompiled the NVIDIA drivers, duh), and a total crash on shutdown=
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
--nextPart3050886.JJdo7gqvQS--
