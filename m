Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313762AbSDHVcK>; Mon, 8 Apr 2002 17:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313763AbSDHVcJ>; Mon, 8 Apr 2002 17:32:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41224 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S313762AbSDHVcI>; Mon, 8 Apr 2002 17:32:08 -0400
Date: Mon, 8 Apr 2002 23:32:09 +0200
From: Pavel Machek <pavel@suse.cz>
To: Brian Litzinger <brian@top.worldcontrol.com>, alan@redhat.com,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Make swsusp actually work
Message-ID: <20020408213209.GG31172@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020407233725.GA15559@elf.ucw.cz> <20020408211558.GA1864@top.worldcontrol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
> > 
> > There were two bugs, and linux/mm.h one took me *very* long to
> > find... Well, those bits used for zone should have been marked. Plus I
> > hack ide_..._suspend code not to panic, and it now seems to
> > work. [Sorry, 2pm, have to get some sleep.]
> 
> I've applied both this patch and the earlier one, and now my
> 2.4.19-pre5-ac3 system can suspend and it can resume.  However,
> when it resumed, I was stuck in the kernel SysRq function.
> 
> Couldn't get out of it.

You should be able to simply press sysrq again.

> And nothing seemed to work, other than it kept displaying the
> help each time I touched a key.

> On the other hand, the swsusp in 2.4.18-WOLK3.3 works correctly.

There should be nothing changed in that area. Perhaps its just timing?

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
