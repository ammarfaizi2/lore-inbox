Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUGXKmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUGXKmU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 06:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268423AbUGXKmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 06:42:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.176]:45303 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S268421AbUGXKmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 06:42:18 -0400
To: Manjunath Prabhu <manjunath.mp@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modify tcp header in the kernel
References: <2de46576040724030153d7877@mail.gmail.com>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sat, 24 Jul 2004 12:41:59 +0200
In-Reply-To: <2de46576040724030153d7877@mail.gmail.com> (Manjunath Prabhu's
 message of "Sat, 24 Jul 2004 15:31:01 +0530")
Message-ID: <87fz7h7klk.fsf@goat.bogus.local>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:fa0178852225c1084dbb63fc71559d78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manjunath Prabhu <manjunath.mp@gmail.com> writes:

> i am using the debian linux and am working on the 2.6.6 kernel.
> i want to access the tcp header, modify it (by passing it through my
> function) and then
> put it back for the regular flow to continue.
> can somebody tell me where i can access TCP header....
> this is what i think should be done.
>
> 1.will using (struct sk_buff*)skb->h.th be sufficient
> 2.using hook to divert the regular flow.
> 3.passing it to my function.
> 4.putting it back.

Maybe iptables is what you're searching for.

Another possibility would be Linux socket filtering. A short
description is in: Documentation/networking/filter.txt

Regards, Olaf.
