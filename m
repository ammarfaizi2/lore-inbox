Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUDPPSr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUDPPSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:18:46 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:63725 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263365AbUDPPSb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:18:31 -0400
Message-ID: <407FFB5E.4070406@rgadsdon2.giointernet.co.uk>
Date: Fri, 16 Apr 2004 16:27:26 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
Reply-To: rgadsdon2@netscape.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>
Subject: 2.6.6-rc1 visor USB - data xfer fails
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Data transfer/sync to Clie via visor/USB fails/disconnects with 2.6.6-rc1:

(from var/log/messages)
Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: visor_write - 
usb_submit_urb(write bulk) failed with status = -19
Apr 16 12:04:27 xxlinux last message repeated 12 times
Apr 16 12:04:27 xxlinux udev[8283]: removing device node '/udev/ttyUSB1'
Apr 16 12:04:27 xxlinux udev[8297]: removing device node '/udev/ttyUSB2'
Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: visor_write - 
usb_submit_urb(write bulk) failed with status = -19
Apr 16 12:04:27 xxlinux last message repeated 8 times
Apr 16 12:04:27 xxlinux kernel: visor ttyUSB1: Handspring Visor / Palm 
OS converter now disconnected from ttyUSB1
Apr 16 12:04:27 xxlinux kernel: visor ttyUSB2: Handspring Visor / Palm 
OS converter now disconnected from ttyUSB2

2.6.5 works OK.

Robert Gadsdon.

