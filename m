Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287790AbSAAK0z>; Tue, 1 Jan 2002 05:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287789AbSAAK0p>; Tue, 1 Jan 2002 05:26:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5907 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287790AbSAAK01>; Tue, 1 Jan 2002 05:26:27 -0500
Subject: Re: kernel lockup?
To: genlogic@mediaone.net (Sam Krasnik)
Date: Tue, 1 Jan 2002 10:37:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C309F51.9050908@mediaone.net> from "Sam Krasnik" at Dec 31, 2001 12:24:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LMID-0008FF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> however, after seeing it still happening, i am led to believe that it may
> be some power management problem or not a kernel problem at all...

It may be several things

> (in which case this mailing list is NOT where i should be posting,
> sorry for the distraction if i am wrong). the lockup only happens after
> extended periods of idle time (specifically in the morning after a night
> of not using the computer). the sysrq works, so i guess it isn't a hard
> lockup? if it is kernel...what then? if not...what could be the problem?

That sounds like the kernel. At 4am lots and lots of I/O intensive things
occur (reindexing the locate cache, removing dead files from /tmp and so on)
If it was a BIOS bug I'd expect it to occur at arbitary times when the box
is idle not the morning after
