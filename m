Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291793AbSBAPHm>; Fri, 1 Feb 2002 10:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291786AbSBAPHX>; Fri, 1 Feb 2002 10:07:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:47367 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291788AbSBAPHO>; Fri, 1 Feb 2002 10:07:14 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: davem@redhat.com (David S. Miller)
Date: Fri, 1 Feb 2002 15:19:28 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        garzik@havoc.gtf.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
In-Reply-To: <20020131.163054.41634626.davem@redhat.com> from "David S. Miller" at Jan 31, 2002 04:30:54 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WfTM-0005PL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL
>    
> This doesn't solve the CRC32 case.  What if you want
> CONFIG_SMALL, yet some net driver that needs the crc32
> routines?

The crc32 dependancy deduction is a seperate problem to asking excessive
questions. That is down to the makefiles. If its hard to express then
presumably Rules.make isnt yet perfect.

Does kbuild make it all simpler ?
