Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269503AbRHCRUw>; Fri, 3 Aug 2001 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269495AbRHCRUm>; Fri, 3 Aug 2001 13:20:42 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:61454 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269505AbRHCRUd>; Fri, 3 Aug 2001 13:20:33 -0400
Subject: Re: Fw: PATCH: creating devices for multiple sound cards
To: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Fri, 3 Aug 2001 18:22:17 +0100 (BST)
Cc: zab@zabbo.net (Zach Brown), rankincj@yahoo.com (Chris Rankin),
        linux-kernel@vger.kernel.org, nerijus@users.sourceforge.net
In-Reply-To: <m2y9p1nk5a.fsf@sympatico.ca> from "Bill Pringlemeir" at Aug 03, 2001 01:11:29 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15SieP-0003bz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If ALSA will replace OSS, then does it make it somewhat futile to add
> things to the current set of sound drivers?  I was going to look at
> the SBLive driver.  I have been side tracked by an xterm bug; it seems
> to have bad handling of utmp on Linux.

Most folks I know are using utmpter for that - it avoids xterm being setuid
setgid or anything else that you really dont want to make it.

As to the sblive - well its probably 2 years away from 2.6 and much of the 
work is being shared - the same bugs turn up in both ALSA and OSS quite
often and several OSS drivers are based off ALSA ones
