Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRAKPKe>; Thu, 11 Jan 2001 10:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129927AbRAKPKZ>; Thu, 11 Jan 2001 10:10:25 -0500
Received: from [216.151.155.116] ([216.151.155.116]:53258 "EHLO
	belphigor.mcnaught.org") by vger.kernel.org with ESMTP
	id <S129790AbRAKPKT>; Thu, 11 Jan 2001 10:10:19 -0500
To: David <davidge@jazzfree.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: es1371 module dependencies problem
In-Reply-To: <Pine.LNX.4.21.0201051729040.952-100000@localhost>
From: Doug McNaught <doug@wireboard.com>
Date: 11 Jan 2001 10:10:12 -0500
In-Reply-To: David's message of "Sat, 5 Jan 2002 17:35:15 +0100 (CET)"
Message-ID: <m38zoirup7.fsf@belphigor.mcnaught.org>
User-Agent: Gnus/5.0806 (Gnus v5.8.6) XEmacs/21.1 (20 Minutes to Nikko)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David <davidge@jazzfree.com> writes:

> kernel: 2.4.0
> modutils: 2.3.23
> 
> loading the es1371 module gives me the following error:
> /lib/modules/2.4.0/kernel/drivers/sound/es1371.o: unresolved symbol
> ac97_probe_codec_Rsmp_1c61c357

It works for me (tm).  Kernel 2.4.0, modutils 2.3.23-2 (Debian
woody).  'modprobe' loads the module quite happily.  I'm running UP,
not SMP, so maybe that's the issue.

You might try a complete rebuild starting from 'make mrproper', and
turn off SMP if you only have one processor. 

-Doug
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
