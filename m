Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965043AbWGEXQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965043AbWGEXQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 19:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965049AbWGEXQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 19:16:49 -0400
Received: from mail.gmx.net ([213.165.64.21]:16558 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965043AbWGEXQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 19:16:49 -0400
X-Authenticated: #5082238
Date: Thu, 6 Jul 2006 01:16:47 +0200
From: Carsten Otto <c-otto@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Frequent reboots with mm6
Message-ID: <20060705231647.GA765@server.c-otto.de>
Reply-To: c-otto@gmx.de
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuGP-Key: http://c-otto.de/pubkey.asc
User-Agent: Mutt/1.5.9i
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!

My server running mm6 restarts every few hours and I have no clue why it
is doing that. I can't see any correlation with load or temperature or
any other event. I might have problems with parts of the hardware (see two
other threads startet by me in the last few days), but this should not
cause a reboot to my knowledge (crashes are fine...). The log files do
not reveal a thing.

Please tell me why a kernel would initialize reboot (or is it the BIOS?
Something else?).

More details:
- 2.6.17-mm6
- 945P chipset with iCH7R doing 4x SATA2 (software raid, AHCI, NCQ(?))
- Pentium D 805 (dualcore)
- Intel PCI Express network card
- running NFS (for a client doing NFS root)

Thanks,
-- 
Carsten Otto
c-otto@gmx.de
www.c-otto.de
