Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRBAIX2>; Thu, 1 Feb 2001 03:23:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRBAIXS>; Thu, 1 Feb 2001 03:23:18 -0500
Received: from mr14.vic-remote.bigpond.net.au ([24.192.1.29]:20198 "EHLO
	mr14.vic-remote.bigpond.net.au") by vger.kernel.org with ESMTP
	id <S130151AbRBAIW6>; Thu, 1 Feb 2001 03:22:58 -0500
From: Darren Tucker <dtucker@zip.com.au>
Message-Id: <200102010822.f118Mlu02001@gate.dodgy.net.au>
Subject: Etherworks3 driver now obsolete?
To: linux-kernel@vger.kernel.org
Date: Thu, 1 Feb 2001 19:22:46 +1100 (EST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

I decided to try a shiny new 2.4.0 kernel but I couldn't configure the driver
for my etherworks3 ISA ethernet card (AMD K6III PC hardware).

A bit of grepping showed that it only appears if CONFIG_OBSOLETE is defined
but nothing in the configuration tools seems to set it (at least for i386).

CONFIG_OBSOLETE is checked for by Config.in for a couple of drivers (net and
char), but the only place it seems to be defined is for the ARM architecture. 

Is this deliberate? Are some of the older drivers to be phased out?
Should there be a "bool 'Prompt for obsolete code/drivers' CONFIG_OBSOLETE"
in the config.in for other architectures, too?

Thanks.

		-Daz.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
