Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUJAUgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUJAUgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUJAUgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:36:41 -0400
Received: from smtp.etmail.cz ([160.218.43.220]:9633 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S266538AbUJAUfQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:35:16 -0400
Date: Fri, 1 Oct 2004 22:35:05 +0200
To: linux-kernel@vger.kernel.org
Subject: [2.6.9-rc3-bk1] Sleeping function called from invalid context
Message-ID: <20041001203505.GA4480@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.6+20040722i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I upgraded from 2.6.8-rc2-bk10.
When I run pppd, a lot of debug messages are typed out.
pppd uses /dev/ttyUSB0 as serial device (driver ftdi_sio).

My .config is at http://wremcont.mysteria.cz/config-2.6.9-rc3-bk1
Kernel debug output is at http://wremcont.mysteria.cz/messages-2.6.9-rc3-bk1


lsusb:
Bus 001 Device 002: ID 0403:6001 Future Technology Devices International, Ltd 8-bit FIFO
Bus 001 Device 001: ID 0000:0000


lspci:
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] (rev 02)
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
0000:00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South] (rev 22)
0000:00:07.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 10)
0000:00:07.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 10)
0000:00:07.4 Host bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev 30)
0000:00:07.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686 AC97 Audio Controller (rev 20)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage 128 Pro Ultra TF


-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E

