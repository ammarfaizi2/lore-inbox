Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277305AbRJORQJ>; Mon, 15 Oct 2001 13:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277823AbRJORPu>; Mon, 15 Oct 2001 13:15:50 -0400
Received: from colorfullife.com ([216.156.138.34]:33810 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277305AbRJORPs>;
	Mon, 15 Oct 2001 13:15:48 -0400
Message-ID: <3BCB19E0.64322276@colorfullife.com>
Date: Mon, 15 Oct 2001 19:16:16 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP processor rework help needed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> For intel the initial determination is made having the cpus race on
> the apic bus.  The cpu that sends a message first gets the lowest
> apicid.  Though I need to see how the P4 Xeon does it, as the apic
> bus is actually unused.

Huh?

24547202.pdf: (i.e. volume 3 of the ia32 SDM)
<<<<<<<<
The APIC ID register is loaded at power up by sampling configuration
data that is driven onto pins of the processor. For the Pentium 4 and P6
family processors, pins A11# and A12# and pins BR0# through BR3# are
sampled; for the Pentium processor, pins BE0# through BE3# are sampled.
<<<<<<

--
	Manfred
