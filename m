Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUIOKmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUIOKmy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 06:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIOKmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 06:42:53 -0400
Received: from main.gmane.org ([80.91.229.2]:21942 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264665AbUIOKmw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 06:42:52 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Georg Schild <dangertools@gmx.net>
Subject: Re: Losing too many ticks! .... on a VIA epia board
Date: Wed, 15 Sep 2004 12:42:40 +0200
Message-ID: <41481CA0.7010802@gmx.net>
References: <4146A09A.9010207@zensonic.dk> <4146BF8C.20309@gmx.net> <20040914135735.GA30310@zensonic.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-153-45-253.dyn.salzburg-online.at
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.2) Gecko/20040820
X-Accept-Language: en-us, en
In-Reply-To: <20040914135735.GA30310@zensonic.dk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Do you have a VIA chipset on this system?

Yes, it's a laptop with a k8t800 chipset. But I have some problems with 
the soulution to disable ACPI though it's a laptop and diabling ACPI 
would say no frequency scaling, no fan regulation etc. Does the PM_Timer 
work on amd64 or isn't it just for x86? I think that i had heard about 
that it wouldn't bring any effect on x86-64. We have discussed this 
issue for a long while on the gentoo amd64 forums though it looks like 
that just amd64 users have this problems.

Here a link but without any useful solution, we had the things with 
disabling ACPI or enabling the PM-Timer already.

http://forums.gentoo.org/viewtopic.php?t=191716

As I know this problem started with kernels later than 2.6.5, don't know 
the exact version, end ended with kernel 2.6.8 which only reports lost 
ticks > 100 by default. But we still loose ticks and i don't like this 
even if i don't see it anymore on dmesg.

Georg Schild

