Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135956AbRDTQNE>; Fri, 20 Apr 2001 12:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135958AbRDTQMx>; Fri, 20 Apr 2001 12:12:53 -0400
Received: from gate.terreactive.ch ([212.90.202.121]:14326 "HELO
	toe.terreactive.ch") by vger.kernel.org with SMTP
	id <S135956AbRDTQMr>; Fri, 20 Apr 2001 12:12:47 -0400
Message-ID: <3AE05F5A.7942C824@tac.ch>
Date: Fri, 20 Apr 2001 18:10:02 +0200
From: Roberto Nibali <ratz@tac.ch>
Organization: terreActive
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en, de-CH, zh-CN
MIME-Version: 1.0
To: Ion Badulescu <ionut@cs.columbia.edu>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <Pine.LNX.4.33.0104200301380.5165-100000@age.cs.columbia.edu>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This was a special case, which btw had nothing to do with the starfire
> driver itself. The user needed to support more than 8 eth ports, which
> 2.2 complains about, and more than 16 eth ports, which 2.2 simply doesn't
> allow without further changes.

I made the changes and I was able to load 4 quadboards, 2 3com cards and
1 eepro100 (onboard) and I did some tests and it works fine. However the
starfire driver seems not to initialize more then 4 quadboards. I put in
5 and he doesn't initialize it and the others don't work although they
get initialized. Is there a trivial way to get more then 4 NIC's of the
same manufacturer running in one box. I also start believing that this
is a motherboard problem since when I put in more the 4 3Com cards, the
boot freezes after the SCSI BIOS init and before the lilo. Does anybody
have the same problem?

Roberto Nibali, ratz

-- 
mailto: `echo NrOatSz@tPacA.cMh | sed 's/[NOSPAM]//g'`
