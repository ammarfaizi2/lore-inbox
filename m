Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSGVOnK>; Mon, 22 Jul 2002 10:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317334AbSGVOnK>; Mon, 22 Jul 2002 10:43:10 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:10169 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S316595AbSGVOnK>; Mon, 22 Jul 2002 10:43:10 -0400
Date: Mon, 22 Jul 2002 16:45:57 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: martin@dalecki.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.5.27 IDE: problems, again. 
Message-ID: <20020722144557.GJ26837@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	martin@dalecki.de,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running the latest (BK head) 2.5 kernel (up to, and including
IDE-clean 100), on my VAIO C1VE laptop:
	00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)

With PIIX chipset support & autodma, the kernel halts right after the
boot, while searching init on the disk. Must happen somewhere with
interrupts disabled (no sysrq, no kbd leds etc).

Disabling PIIX chipset support & dma makes the kernel survive for 
some longer time (between 10 seconds and 2-3 minutes), but it will
eventually halt, this time CORRUPTING THE DATA!

Right now I'm trying to recover my disk partition...

Stelian, more and more enclined to switch to the IDE 2.4 back^H^H^H^Hforward 
port.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
