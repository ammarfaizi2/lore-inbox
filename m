Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312839AbSDBKvc>; Tue, 2 Apr 2002 05:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312841AbSDBKvN>; Tue, 2 Apr 2002 05:51:13 -0500
Received: from ns1.advfn.com ([212.161.99.144]:44806 "EHLO mail.advfn.com")
	by vger.kernel.org with ESMTP id <S312839AbSDBKvK>;
	Tue, 2 Apr 2002 05:51:10 -0500
Message-Id: <200204021051.g32Ap6s12049@mail.advfn.com>
Content-Type: text/plain; charset=US-ASCII
From: Tim Kay <timk@advfn.com>
Reply-To: timk@advfn.com
Organization: Advfn.com
To: linux-kernel@vger.kernel.org
Subject: What am I losing with noapic
Date: Tue, 2 Apr 2002 10:53:08 +0000
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	Does anyone know what I'm actually losing with having to set noapic on 
bootup? I mean in real terms how much harder / slower is an SMP machine 
working when it's doing standard multi-bus xt polling compared to when it's 
in APIC poll state. I appreciate that there can be a reduction in interrupt 
response latency using the damn thing but is this a measurable amount given a 
machine processing about 1200 interrupts/sec? (this figure is a sum rather 
than per processor). As an added complication how do I get around interrupt 
routing conflicts in noapic mode and do the 'routing conflict for xx:xx:xx 
have X want Y' messages make any difference to this performance?

	A useful URL (I couldn't find any) or reference would suffice if this is too 
invloved or boring a topic to explain easily.

TIA

Tim

-- 
----------------
Tim Kay
systems administrator
Advfn.com Plc - http://www.advfn.com/
