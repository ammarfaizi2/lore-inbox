Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSGMQVH>; Sat, 13 Jul 2002 12:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSGMQVG>; Sat, 13 Jul 2002 12:21:06 -0400
Received: from t5o53p51.telia.com ([212.181.176.51]:2436 "EHLO
	best.localdomain") by vger.kernel.org with ESMTP id <S315192AbSGMQVF>;
	Sat, 13 Jul 2002 12:21:05 -0400
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
References: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
From: Peter Osterlund <petero2@telia.com>
Date: 13 Jul 2002 18:22:01 +0200
In-Reply-To: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
Message-ID: <m2n0svr42e.fsf@best.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linuxpower.ca> writes:

> did the higher duty cycles have the desired effect?

Not really, unfortunately. The CPU certainly runs slower, but the
difference in power consumption between the fastest and slowest speeds
seems to be quite small. The kernel was configured to use APM idle
calls, but no ACPI stuff. I measured the time it took for the battery
to go from 100% to 90% while reading the lkml mailing list with gnus,
so the machine was mostly idle during the test.

How much power savings can be expected in this situation? Is SpeedStep
likely to give more power savings?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
