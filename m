Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266143AbUJTGTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266143AbUJTGTo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 02:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269536AbUJTGTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 02:19:17 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:39647 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266143AbUJTGQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 02:16:52 -0400
Date: Wed, 20 Oct 2004 08:16:47 +0200
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Instances of visor us devices are not deleted (2.6.9-rc4-mm1)
Message-ID: <20041020061647.GA20692@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi USB developers!

I have the following problem with 2.6.9-rc4-mm1 which includes bk-usb:

Everytime I sync my palm I get a new device id:

...start sync...
usb 4-2.1: new full speed USB device using address 8
visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB2
usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB3
...
...many usb usb2: string descriptor 0 read error: -113 ...
...
...end of sync...
usb 4-2.1: USB disconnect, address 8
visor 4-2.1:1.0: device disconnected
visor ttyUSB3: visor_write - usb_submit_urb(write bulk) failed with status = -19
...new sync...
usb 4-2.1: new full speed USB device using address 9
visor 4-2.1:1.0: Handspring Visor / Palm OS converter detected
usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB4
usb 4-2.1: Handspring Visor / Palm OS converter now attached to ttyUSB5

etc etc.

Is this a known problem?

(debian/sid, 2.6.9-rc4-mm1)

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
WIDDICOMBE (n.)
The sort of person who impersonates trim phones.
			--- Douglas Adams, The Meaning of Liff
