Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271616AbRIBMBu>; Sun, 2 Sep 2001 08:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271612AbRIBMBk>; Sun, 2 Sep 2001 08:01:40 -0400
Received: from mustard.heime.net ([194.234.65.222]:47028 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271329AbRIBMBX>; Sun, 2 Sep 2001 08:01:23 -0400
Date: Sun, 2 Sep 2001 14:01:40 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
Subject: error compiling 2.4.9 with ess solo1 support
Message-ID: <Pine.LNX.4.30.0109021359550.3737-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all

I get the following error message when compiling (or rather linking) 2.4.9
with ESS Solo1 support. Anyone have a clue?

Please cc: to me as I'm not on the list

roy


drivers/sound/sounddrivers.o: In function `solo1_probe':
drivers/sound/sounddrivers.o(.text+0xf8ab): undefined reference to `gameport_register_port'
drivers/sound/sounddrivers.o: In function `solo1_remove':
drivers/sound/sounddrivers.o(.text+0xf9d7): undefined reference to `gameport_unregister_port'


