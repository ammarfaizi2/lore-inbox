Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261768AbSJCQDe>; Thu, 3 Oct 2002 12:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbSJCQDd>; Thu, 3 Oct 2002 12:03:33 -0400
Received: from 62-190-202-9.pdu.pipex.net ([62.190.202.9]:58116 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261768AbSJCQDb>; Thu, 3 Oct 2002 12:03:31 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210031616.g93GGAjO000918@darkstar.example.net>
Subject: Re: [OT] 2.6 not 3.0 - (WAS Re: [PATCH-RFC] 4 of 4 - New problem
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 3 Oct 2002 17:16:10 +0100 (BST)
Cc: kessler@us.ibm.com, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       saw@saw.sw.com.sg, rusty@rustcorp.com.au, richardj_moore@uk.ibm.com
In-Reply-To: <Pine.LNX.4.44.0210030852330.2066-100000@home.transmeta.com> from "Linus Torvalds" at Oct 03, 2002 08:57:13 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 3 Oct 2002 jbradford@dial.pipex.com wrote:
> > 
> > I think we should stick to incrementing the major number when binary
> > compatibility is broken.
> 
> "Stick to"? We've never had that as any criteria for major numbers in the
> kernel. Binary compatibility has _never_ been broken as a release policy,
> only as a "that code is old, and we've given people 5 years to migrate to
> the new system calls, the old ones are TOAST".

Ah, I was getting confused, I thought that the move to 2.0 was when we moved from a.out to elf.  I didn't really follow kernel development very closely at all back then, to be truthful.

> The only policy for major numbers has always been "major capability
> changes".

Then it definitely shouldn't be 3.0 yet then.

> 1.0 was "networking is stable and generally usable" (by the
> standards of that time), while 2.0 was "SMP and true multi-architecture
> support". My planned point for 3.0 was NuMA support, but while we actually
> have some of that, the hardware just isn't relevant enough to matter.

Hmmm, then for 3.0 I'd vote for fully working and proven stable:

* High memory support, 
* IPV6
* IDE-SCSI
* Bluetooth
* USB (2)
* IEEE 1394

> The memory management issues would qualify for 3.0, but my argument there 
> is really that I doubt everybody really is happy yet. Which was why I 
> asked for people to test it and complain about VM behaviour - and we've 
> had some ccomplaints ("too swap-happy") although they haven't sounded like 
> really horrible problems.

To be completely honest, I dont't see any improvement in 2.5.x over 2.4.x on my boxes that are running both :-(.

John.
