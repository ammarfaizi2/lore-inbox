Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266317AbUAGV3W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 16:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266318AbUAGV3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 16:29:22 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:38406
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S266317AbUAGV3T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 16:29:19 -0500
Date: Wed, 7 Jan 2004 22:29:16 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Subject: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040107212916.GA978@man.manty.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a SB16PNP on which alsa under kernel 2.6 fails to detect the OPL
chip, I have tried the 0.9.7 version wich comes with the kernel (up to
version 2.6.1-rc2) and now even alsa 1.0.0rc2 compiled for the 2.6.1-rc2
kernel, on both I get the same result:

sb16: no OPL device at 0x388-0x38a

this is the full output on version 1.0.0rc2:

Starting ALSA (version 1.0.0rc2):pnp: Device 00:01.00 activated.
ALSA /usr/src/modules/alsa-driver/alsa-kernel/isa/sb/sb16.c:489: sb16: no
OPL device at 0x388-0x38a
 sb16.

Alsa version 0.9.8 works perfectly under 2.4.X.

Don't hesitate to contact me for any other info that may be needed to track
this.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
