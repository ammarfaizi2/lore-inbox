Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135615AbRDSK5O>; Thu, 19 Apr 2001 06:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135617AbRDSK5E>; Thu, 19 Apr 2001 06:57:04 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:26353 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135615AbRDSK44>; Thu, 19 Apr 2001 06:56:56 -0400
Message-ID: <3ADEC3CE.CC58F06A@tac.ch>
Date: Thu, 19 Apr 2001 12:54:06 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Steve Hill <steve@navaho.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104181330200.32629-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> True, I plead guilty to the "replying at 3:30am" sin. :-) I meant to reply
> to Roberto's mail, and accidentally replied to yours..

That's what I thought ...
 
> Anyway, Roberto, if you could give the starfire driver in 2.2.19 a try,
> I'd appreciate it. You mentioned looking at the code, did you actually
> test it?

Today I started testing it and indeed, as the code shows, I works now. The
main problem was that if you compiled the driver into the kernel and only
had one Quadboard, it would get initialized twice. It worked but was nasty
to configure ;).
Now I started my tests with the new driver from plain vanilla 2.2.19 kernel
and it worked for my problem above. I've you're interested I could send you
some dmesg and proc-fs outputs. I'm working on a Intel L440GX+ SMP board 
but with one processor, a stopper card and SMP disabled. Unfortunately a
guy back here destroyed the board by trying to hotplug the Quadboard and
touching the motherboard's voltage regulator. I have to get a new one to
continue my tests with 3 or 4 Quadboards. Will be back in a few hours with
the remaining results.

Best regards,
Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
