Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129213AbQKQWGE>; Fri, 17 Nov 2000 17:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129219AbQKQWFz>; Fri, 17 Nov 2000 17:05:55 -0500
Received: from lipta.cendio.se ([193.180.23.53]:13828 "EHLO lipta.cendio.se")
	by vger.kernel.org with ESMTP id <S129213AbQKQWFo>;
	Fri, 17 Nov 2000 17:05:44 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: VGA PCI IO port reservations
In-Reply-To: <200011171953.TAA01877@raistlin.arm.linux.org.uk> <Pine.LNX.3.95.1001117145621.23447A-100000@chaos.analogic.com>
From: Marcus Sundberg <marcus@cendio.se>
Date: 17 Nov 2000 22:35:41 +0100
In-Reply-To: root@chaos.analogic.com's message of "Fri, 17 Nov 2000 14:59:04 -0500 (EST)"
Message-ID: <ven1eye0ya.fsf@lipta.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@chaos.analogic.com ("Richard B. Johnson") writes:

[about PCI setup code]

> This stuff has to be set up before you
> have any resources necessary to execute the output of a 'C' compiler,
> so, if you are looking for 'C' syntax, you are out of luck.

Sorry, but that's plain rubbish.
Some things in bootcode usually have to be done in assembly, but
PCI setup is definitely *not* among them, unless you have some
really unique hardware. Hell, I've even written bootcode where
the memory-controller is set up from C.

//Marcus
-- 
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
