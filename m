Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVCULm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVCULm5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 06:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVCULm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 06:42:57 -0500
Received: from relay.muni.cz ([147.251.4.35]:30649 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S261757AbVCULm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 06:42:56 -0500
Date: Mon, 21 Mar 2005 12:42:45 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@yahoo.com, mdharm-usb@one-eyed-alien.net
Subject: drivers/block/ub.c and multiple LUNs
Message-ID: <20050321114245.GK25997@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hello,

is the ub.c USB storage driver supposed to work with multi-LUN(?)
devices? I have a Palm Tungsten T5, which in drive mode looks like two
USB storage devices (the internal flash is one LUN and the SD/MMC card in
the slot is another one). With usb_storage driver I can see both devices,
with ub driver I can see the internal flash only.

	I have moved back to usb_storage driver for now, but I am willing
to provide more info if somebody is interested in making ub.c driver working
with both devices on Tungsten T5.

	Thanks,

-Yenya

PS.: There is no MAINTAINERS file entry for the ub.c driver, and Pete Zaitcev
	is not even listed in the CREDITS file.
	
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
