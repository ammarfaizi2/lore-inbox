Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313432AbSDGTXc>; Sun, 7 Apr 2002 15:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313434AbSDGTXb>; Sun, 7 Apr 2002 15:23:31 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:50185 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S313432AbSDGTXb>; Sun, 7 Apr 2002 15:23:31 -0400
Date: Sun, 7 Apr 2002 20:23:25 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Steven N. Hirsch" <shirsch@adelphia.net>, linux-kernel@vger.kernel.org
Subject: Re: Two fixes for 2.4.19-pre5-ac3
Message-ID: <20020407192324.GA21491@compsoc.man.ac.uk>
In-Reply-To: <20020407173343.GA18940@compsoc.man.ac.uk> <E16uIB6-0006TQ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 07, 2002 at 08:18:16PM +0100, Alan Cox wrote:

> How about "there are no correct users". Its basically impossible to patch
> the syscall table safely anyway. As Arjan pointed out there are races 
> against module unload that on SMP are basically incurable.

can_unload == FALSE

> Doing the right hooks makes the AFS code portable which is a big win.

Definitely. I'm not for a minute arguing that the nfsservctl-style thing
is not how it should be done for those cases.

I'll genuinely take on board advice on how I can profile all the system
via x86 perf counters efficiently without having to patch the kernel.
The old way just uses sys_call_table. So what do I do now ?

I've actually *tried* doing the /proc-reading thing. It's very low
resolution and/or too slow.

regards
john

-- 
"I never understood what's so hard about picking a unique
 first and last name - and not going beyond the 6 character limit."
 	- Toon Moene
