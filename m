Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbUDFA3K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 20:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263558AbUDFA3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 20:29:10 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:45573 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S263557AbUDFA3I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 20:29:08 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Kitt Tientanopajai <kitt@gear.kku.ac.th>
Subject: Re: 2.6.5 yenta_socket irq 10: nobody cared!
Date: Tue, 6 Apr 2004 02:27:58 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404060227.58325.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a known problem with the acer travelmate 361. it reports IRQ 11 for
the O2Micro cardbus bridge when it is in reality IRQ 10.

see:
	http://www.naos.co.nz/hardware/laptop/acer-361evi/x94.html#AEN138
and
	http://sourceforge.net/tracker/index.php?func=detail&aid=533863&group_id=2405&atid=102405


please give a full dmesg and a lspci -vvvn.
are you using ACPI?

