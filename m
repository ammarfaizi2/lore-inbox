Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTEIQfg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 12:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263322AbTEIQfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 12:35:36 -0400
Received: from 217-126-36-165.uc.nombres.ttd.es ([217.126.36.165]:25313 "EHLO
	pau.intranet.ct") by vger.kernel.org with ESMTP id S263320AbTEIQfe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 12:35:34 -0400
Date: Fri, 9 May 2003 18:47:59 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: no console found booting 2.5.69
Message-ID: <Pine.LNX.4.44.0305091844370.1574-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I still find no way to boot a 2.5.6x kernel.
It reports (more or less) : "no console found, specify init= option"

This is the relevant part of my config:
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_LP_CONSOLE is not set
CONFIG_VGA_CONSOLE=y
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

What am I missing?

Another problem is the PCMCIA that I already reported for 2.5.68; it 
stalls if I don't remove the Cardbus card.

Pau

