Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264987AbSJaAUo>; Wed, 30 Oct 2002 19:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264988AbSJaAUo>; Wed, 30 Oct 2002 19:20:44 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:20164 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S264987AbSJaAUm>;
	Wed, 30 Oct 2002 19:20:42 -0500
Date: Thu, 31 Oct 2002 01:27:05 +0100
From: =?iso-8859-1?Q?J=2EA=2E_Magall=F3n?= <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: [RFC] Pending bugfixes for 2.4.20 ?
Message-ID: <20021031002705.GA3587@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

We are in -rc, so only bugfixes ;)
I have this collection of things posted in LKML as bugfixes, that still
apply on top of rc1. Could you include if appropiate for next -rc, plz ?

List:

02-printk
    Kill extra printk declaration.
    Author: David Howells <dhowells@redhat.com>
	
03-clone-detached
    Fix a crash that can be caused by a CLONE_DETACHED thread.
    Author: Ingo Molnar <mingo@elte.hu>

04-module-size-checks
    Fixes two minor bugs in kernel/module.c related with module size checks.
    Author: Peter Oberparleiter <oberpapr@softhome.net>

06-memparam
    Fix mem=XXX kernel parameter when user gives a size bigger than what
    kernel autodetected (kill a previous change)
    Author: Adrian Bunk <bunk@fs.tum.de>,
            Leonardo Gomes Figueira <sabbath@planetarium.com.br>

07-cache-detection
    Fix cache detection, adds trace cache detection.
    Author: Dave Jones <davej@codemonkey.org.uk>

08-highpage-init
    Cleanup one_highpage_init() as in 2.5.
    Author: Christoph Hellwig <hch@sgi.com>

09-self_exec_id
    Fix bad signaling between threads when ancestor dies.
    Author: Zeuner, Axel <Axel.Zeuner@partner.commerzbank.com>

If somebody has anything to say, or has updated versions...

TIA

--
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-rc1-jam0 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
