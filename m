Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWFLNIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWFLNIq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 09:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751945AbWFLNIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 09:08:46 -0400
Received: from twin.jikos.cz ([213.151.79.26]:42978 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1751937AbWFLNIp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 09:08:45 -0400
Date: Mon, 12 Jun 2006 15:08:41 +0200
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: PC card RS-232 freezes the computer
Message-ID: <20060612130841.GA16993@kestrel.barix.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Orientation: Gay
X-Stance: Goofy
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When I insert "2 port RS-232" PC card/PCMCIA/carbus/whatever card
(86x53x6mm with a golden strip with 8 nipples and 2x34 connector) into my
Dell Inspiron 510m notebook with 2.6.16.19, the computer freezes and
continues working when I remove it.

The card label says "2 port RS-232 SUNIX Plug Into A Brand-new World
S/N: CB 0077996 Made in Taiwan"

XMMS before freezing plays last 300ms 3 times again.

dmesg shows
pccard: CardBus card inserted into slot 0
pccard: card ejected from slot 0
MCE: The hardware reports a non fatal, correctable incident occurred on
CPU 0.
Bank 0: b200004000000800

Is the kernel intended to behave this way? If yes, is there a way how
to configure up the kernel so the computer doesn't freeze and the card
can be examined with lspci?

CL<
