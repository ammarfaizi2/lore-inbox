Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbTDUX1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbTDUX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 19:27:51 -0400
Received: from CPE-203-51-32-18.nsw.bigpond.net.au ([203.51.32.18]:44536 "EHLO
	e4.eyal.emu.id.au") by vger.kernel.org with ESMTP id S262689AbTDUX1u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 19:27:50 -0400
Message-ID: <3EA48145.70A5589@eyal.emu.id.au>
Date: Tue, 22 Apr 2003 09:39:49 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-e3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc1 - unresolved
References: <Pine.LNX.4.53L.0304211545580.12940@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> Here goes the first candidate for 2.4.21.
> 
> Please test it extensively.

depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_msghandler.o
depmod:         panic_notifier_list
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1/kernel/drivers/char/ipmi/ipmi_watchdog.o
depmod:         panic_notifier_list
depmod:         panic_timeout
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1/kernel/drivers/net/fc/iph5526.o
depmod:         fc_type_trans
depmod: *** Unresolved symbols in
/lib/modules/2.4.21-rc1/kernel/drivers/net/wan/comx.o
depmod:         proc_get_inode

The ipmi ones are old, the fc is new, the comx is well known.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
