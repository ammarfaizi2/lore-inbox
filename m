Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261600AbTBSVW2>; Wed, 19 Feb 2003 16:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261624AbTBSVW2>; Wed, 19 Feb 2003 16:22:28 -0500
Received: from CPE-203-51-35-219.nsw.bigpond.net.au ([203.51.35.219]:1009 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S261600AbTBSVW1>; Wed, 19 Feb 2003 16:22:27 -0500
Message-ID: <3E53F7E8.FF3F8955@eyal.emu.id.au>
Date: Thu, 20 Feb 2003 08:32:24 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.21-pre4-aa3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.24-rc4 - unresolved
References: <200302191412.h1JECmG25452@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

an all-modules (i386) build has this one unresolved:

depmod: *** Unresolved symbols in /lib/modules/2.2.24-rc4/net/smc9194.o
depmod:         netif_wake_queue

in .config:
CONFIG_SMC9194=m

This looks like a macro definition missing in smc9194.c?

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
