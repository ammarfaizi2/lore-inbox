Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264090AbRFETss>; Tue, 5 Jun 2001 15:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264092AbRFETsi>; Tue, 5 Jun 2001 15:48:38 -0400
Received: from [216.156.138.34] ([216.156.138.34]:1042 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S264090AbRFETs1>;
	Tue, 5 Jun 2001 15:48:27 -0400
Message-ID: <3B1D3770.FB726B17@colorfullife.com>
Date: Tue, 05 Jun 2001 21:48:00 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-ac6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: jalaja devi <jala_74@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: smp errors in 2.4!!
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I encounter this compilation error:
> /usr/x.c:2112: struct has no member named
> "event_Rsmp_7b16c344"

I assume you have a variable called 'event', and that name got replaced
by a versioned symbol.
Yes, 'event' is a global variable in the kernel ;-)

Do you include <linux/modversions.h> in that file?

I usually use 'gcc -E' to find such problems.

--
	Manfred
