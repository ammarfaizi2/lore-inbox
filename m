Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261463AbSI2Rz1>; Sun, 29 Sep 2002 13:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261468AbSI2Rz1>; Sun, 29 Sep 2002 13:55:27 -0400
Received: from pa90.banino.sdi.tpnet.pl ([213.76.211.90]:56846 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261463AbSI2Rz0>; Sun, 29 Sep 2002 13:55:26 -0400
Subject: Re: [patch] fix parport_serial / serial link order (for 2.4.20-pre8)
In-Reply-To: <Pine.LNX.4.44.0209280021030.32347-100000@montezuma.mastecende.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Date: Sun, 29 Sep 2002 20:00:41 +0200 (CEST)
CC: Marek Michalkiewicz <marekm@amelek.gda.pl>, twaugh@redhat.com,
       serial24@macrolink.com, Linux Kernel <linux-kernel@vger.kernel.org>
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17viMz-0006UO-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Piece-Of-Shh... ;)

Hmm, works fine here so far, though I only have tested the parallel
port in polling mode (that's how it is set up by default).

> 00:0e.0 Communication controller: NetMos Technology 222N-2 I/O Card (2S+1P) (rev 01)

Mine is "ST Lab PCI 2S1P IO Controller Card" - which has no serial
configuration EEPROM (there is an empty place for it on the PCB).
The 9710:9835 numbers are the generic defaults hardwired in the
NM9835 chip, not specific to any board type like "222N-2".

> I have been using this setup for a while now.

I haven't heard anything from the kernel people yet - any chances of
getting these changes into the official 2.4.x source?  I can make
a second patch (NetMos support) after the first one is accepted...

Marek

