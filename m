Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269155AbRHLNL4>; Sun, 12 Aug 2001 09:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269158AbRHLNLg>; Sun, 12 Aug 2001 09:11:36 -0400
Received: from hera.omc.net ([212.98.78.18]:53000 "EHLO hera.omc.net")
	by vger.kernel.org with ESMTP id <S269155AbRHLNLa>;
	Sun, 12 Aug 2001 09:11:30 -0400
From: "Max Schattauer" <smax@smaximum.de>
To: linux-kernel@vger.kernel.org
Date: Sun, 12 Aug 2001 15:11:32 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: tun device: File descriptor in bad state(77)
Message-ID: <3B769CA4.11035.A9DFE2@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there!

I graded up from kernel 2.4.5 to 2.4.8 and now have trouble with 
vtund 2.5b1 and tun 1.1. 

vtund[532]: Session st_sm[217.230.44.100:1577] opened
vtund[532]: Can't allocate tun device. File descriptor in bad state(77)
vtund[532]: Session st_sm closed

Also

root:~# cat /dev/net/tun
cat: /dev/net/tun: File descriptor in bad state

Tried to recompile both packages and created a new device but 
without effect.

Best regards,

Max
