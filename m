Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261973AbSLZDgg>; Wed, 25 Dec 2002 22:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbSLZDgg>; Wed, 25 Dec 2002 22:36:36 -0500
Received: from itaqui.terra.com.br ([200.176.3.19]:21203 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP
	id <S261973AbSLZDgg>; Wed, 25 Dec 2002 22:36:36 -0500
Message-ID: <3E0A5E65.5030601@terra.com.br>
Date: Thu, 26 Dec 2002 01:41:57 +0000
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Josh Brooks <user@mail.econolodgetulsa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU failures ... or something else ?
References: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
In-Reply-To: <20021225175232.O6873-100000@mail.econolodgetulsa.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Josh Brooks wrote:
> Hello,
> 
> I have a dual p3 866 running 2.4 kernel that is crashing once every few
> days leaving this on the console:
> 
> 
> Message from syslogd@localhost at Tue Dec 24 11:30:31 2002 ...
> localhost kernel: CPU 1: Machine Check Exception: 0000000000000004
> 
> Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> localhost kernel: Bank 4: b200000000040151
> 
> Message from syslogd@localhost at Tue Dec 24 11:30:32 2002 ...
> localhost kernel: Kernel panic: CPU context corrupt
> 
> Word on the street is that this indicates hardware failure of some kind
> (cpu, bus, or memory).  My main question is, is that very surely the
> culprit, or is it also possible that all of the hardware is perfect and
> that a bug in the kernel code or some outside influence (remote exploit)
> is causing this crash ?

	Instruction fetch error from the level 1 cache...I've seen this before 
(check the archives). This indicates either a memory or a processor problem.

	Could you please run memtest86?

	Thanks.

Felipe

