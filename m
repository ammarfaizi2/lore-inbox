Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTIJQ0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265229AbTIJQ0q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:26:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:27085 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265153AbTIJQZu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:25:50 -0400
Date: Wed, 10 Sep 2003 09:20:01 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5-mm1 aha152x **still** doesn't work (fwd)
Message-Id: <20030910092001.4c7908e7.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.3.96.1030910101202.21238F-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030910101202.21238F-100000@gatekeeper.tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Sep 2003 10:14:37 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:

| 
| oddball:root> modprobe aha152x aha152x=0x340,9,7,1,1,1
| SCSI subsystem initialized
| aha152x: invalid module params io=0x340, irq=8,scsiid=7,reconnect=1,parity=1,sync=1,delay=1000,exttrans=0
| FATAL: Error inserting aha152x 
| (/lib/modules/2.6.0-test5-mm1/kernel/drivers/scsi/aha152x.ko): No such 
| device
| 
| 
| It happily looks at the "9" in the init string and says "irq=8" doesn't 
| work. Works with the 2.4.18 kernel from RH7.3, so ??? The IRQ jumpers are 
| soldered on the board.
| 
| Clearly if I had the option of using another board I would, that's not
| going to happen for various reasons (administrative and technical).

Wow, looks odd alright.  What is CONFIG_PCMCIA?  (yes/no/module)
What is CONFIG_ISAPNP?  Just send me your .config file, please.

--
~Randy
