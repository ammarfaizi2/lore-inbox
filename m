Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318915AbSH1Tbv>; Wed, 28 Aug 2002 15:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318916AbSH1Tbu>; Wed, 28 Aug 2002 15:31:50 -0400
Received: from p50846B1C.dip.t-dialin.net ([80.132.107.28]:60646 "EHLO
	sol.fo.et.local") by vger.kernel.org with ESMTP id <S318915AbSH1Tbt>;
	Wed, 28 Aug 2002 15:31:49 -0400
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PDC20262 IDE - DMA no go? - And "dump" question
References: <m31y8iooai.fsf@terra.fo.et.local>
	<200208282125.15241.roger.larsson@skelleftea.mail.telia.com>
From: Joachim Breuer <jmbreuer@gmx.net>
Date: Wed, 28 Aug 2002 21:36:08 +0200
In-Reply-To: <200208282125.15241.roger.larsson@skelleftea.mail.telia.com> (Roger
 Larsson's message of "Wed, 28 Aug 2002 21:25:15 +0200")
Message-ID: <m3vg5un5cn.fsf_-_@terra.fo.et.local>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.4 (Common Lisp,
 i386-redhat-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Larsson <roger.larsson@skelleftea.mail.telia.com> writes:
> On Wednesday 28 August 2002 20.01, Joachim Breuer wrote:
>> D. I think the fs is hosed, format it and restore from backup. Next
>> fsck shows it has errors. Correct them. Just to be on the safe side,
>> reboot and fsck again. Guess what. So it seems that in this
>> configuration an fsck under 2.4.19-rc1-ac2 would corrupt the fs it's
>> trying to fix.
>
> After reading this I have to ask.
> You are not trying to fsck a mounted partion are you?

No sweat, I'm not. - BTW, anyone know since when it is again/when it
will be "safe" (as in not corrupting the fs) to use dump on a mounted
but idle fs? - I could use lvm snapshots as well, last I heard there
was some "bug" in the buffer cache corrupting data when dump was used
even on an ro, but mounted, fs.


So long,
   Joe

-- 
"I use emacs, which might be thought of as a thermonuclear
 word processor."
-- Neal Stephenson, "In the beginning... was the command line"
