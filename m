Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265790AbRF2JMW>; Fri, 29 Jun 2001 05:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265797AbRF2JMM>; Fri, 29 Jun 2001 05:12:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:772 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265793AbRF2JMC>; Fri, 29 Jun 2001 05:12:02 -0400
Subject: Re: Linux 2.4.5-ac21
To: gspen@home.com (Garett Spencley)
Date: Fri, 29 Jun 2001 10:11:48 +0100 (BST)
Cc: laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0106282143240.19421-100000@localhost.localdomain> from "Garett Spencley" at Jun 28, 2001 09:46:49 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15FuJY-0008Lo-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pnp_bios.c: In function `pnp_dock_event':
> pnp_bios.c:442: `hotplug_path' undeclared (first use in this function)
> pnp_bios.c:442: (Each undeclared identifier is reported only once
> pnp_bios.c:442: for each function it appears in.)
> pnp_bios.c: In function `pnp_dock_thread':
> pnp_bios.c:496: warning: `d' might be used uninitialized in this function
> pnp_bios.c: At top level:
> pnp_bios.c:597: warning: `pnp_bios_exit' defined but not used

Turn on CONFIG_HOTPLUG for now. I'll fix that one

