Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291453AbSBAAa5>; Thu, 31 Jan 2002 19:30:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291454AbSBAAas>; Thu, 31 Jan 2002 19:30:48 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61458 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291453AbSBAAac>; Thu, 31 Jan 2002 19:30:32 -0500
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does
To: davem@redhat.com (David S. Miller)
Date: Fri, 1 Feb 2002 00:42:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, vandrove@vc.cvut.cz, torvalds@transmeta.com,
        garzik@havoc.gtf.org, linux-kernel@vger.kernel.org, paulus@samba.org,
        davidm@hpl.hp.com, ralf@gnu.org
In-Reply-To: <20020131.162549.74750188.davem@redhat.com> from "David S. Miller" at Jan 31, 2002 04:25:49 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16WRmu-0003iO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I did propose was to eliminate the Config.in special casings all
> over the place to turn this stuff on.  It's just a wart when I look at
> it.  But you don't seem to like that idea so I'll drop it.

I'd like to eliminate lots of the magic weird cases in Config.in too - but
by making the language express it. Something like

tristate_orif "blah" CONFIG_FOO $CONFIG_SMALL

