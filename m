Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbULNCTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbULNCTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 21:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbULNCTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 21:19:18 -0500
Received: from pop-a065c10.pas.sa.earthlink.net ([207.217.121.184]:28379 "EHLO
	pop-a065c10.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S261366AbULNCTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 21:19:14 -0500
From: Bill Chimiak <bchimiak@earthlink.net>
To: linux-kernel@vger.kernel.org
Subject: visor.ko freezes on dlpsh list
Date: Mon, 13 Dec 2004 21:19:52 -0500
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412132119.52402.bchimiak@earthlink.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary: Handspring visor does not  fully sync with kpilot or jpilot
or with pilot-xfer.
With dlpsh, the user, and df work but it freezes with a ls command
after completing about 75% to 80% of the actually listing.

Stupid attempts to get it to work better:
I have tried different settings in the /etc/udev/rules.d and permissions.d
opening the permission wide open and making the user the full owner -
no joy.  I tried a previous visor.c from another kernel and the compiler puked
at me.

Other info:
Nothing here looks wierd:
13 21:14:25 kernel: usb 4-2: new full speed USB device using address 29
13 21:14:25 kernel: usb 4-2: Handspring Visor / Palm OS: port 1, is for
 Generic use
13 21:14:25 kernel: usb 4-2: Handspring Visor / Palm OS: port 2, is for
 HotSync use
13 21:14:25 kernel: usb 4-2: Handspring Visor / Palm OS: Number of port
s: 2
13 21:14:25 kernel: visor 4-2:1.0: Handspring Visor / Palm OS converter
 detected
13 21:14:25 kernel: usb 4-2: Handspring Visor / Palm OS converter now a
ttached to ttyUSB0
13 21:14:25 kernel: usb 4-2: Handspring Visor / Palm OS converter now a
ttached to ttyUSB1
13 21:15:02 crond(pam_unix)[26693]: session closed for user root
13 21:15:10 kernel: usb 4-2: USB disconnect, address 29
13 21:15:10 kernel: visor ttyUSB0: Handspring Visor / Palm OS converter
 now disconnected from ttyUSB0

Thnx
bill chimiak
w.chimiak@computer.org
