Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311614AbSC2TS4>; Fri, 29 Mar 2002 14:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311615AbSC2TSr>; Fri, 29 Mar 2002 14:18:47 -0500
Received: from bitmover.com ([192.132.92.2]:12943 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S311614AbSC2TSe>;
	Fri, 29 Mar 2002 14:18:34 -0500
Date: Fri, 29 Mar 2002 11:18:33 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Henning P. Schmiedehausen" <hps@intermeta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bkbits.net down
Message-ID: <20020329111833.B6490@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Henning P. Schmiedehausen" <hps@intermeta.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203271853.g2RIrRv11812@work.bitmover.com> <20020327222738.B16149@work.bitmover.com> <20020328112252.F22352@work.bitmover.com> <a81gte$hrj$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 10:50:22AM +0000, Henning P. Schmiedehausen wrote:
> Larry McVoy <lm@bitmover.com> writes:
> 
> >The drive has bad blocks and when it hits them it goes into retry la la land,
> >so I won't know which data is bad until I hit the bad blocks.
> 
> You've learned now the hard way why integrity checks in an application
> will never be able to replace things like backups or RAID systems. 
> Maybe you want to reread the flamewar^Wthread from some time ago with
> your new knowledge.

You obviously didn't read that thread.  Both in the context of
BitKeeper and in the context of normal data, you would have seen that
we have backups, we just have backups that we can verify are correct.
The repositories on bkbits.net are automirrored after each incoming event.
There were a few ppc ones which were not and we're still trying to figure
out why, and things like the .ssh keys were not completely backed up;
we're fixing that by putting that information into a BK repository so
it will just automirror like everything else.

I'm not sure why you yanking my chain, it's counter productive and 
flat out rude after I just spent two days doing nothing but putting 
things back together for kernel developers.  What, exactly, did you
hope to accomplish?
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
