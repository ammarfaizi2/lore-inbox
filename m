Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129439AbRBEUQp>; Mon, 5 Feb 2001 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129504AbRBEUQf>; Mon, 5 Feb 2001 15:16:35 -0500
Received: from ganymede.or.intel.com ([134.134.248.3]:40975 "EHLO
	ganymede.or.intel.com") by vger.kernel.org with ESMTP
	id <S129439AbRBEUQY>; Mon, 5 Feb 2001 15:16:24 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDFFC@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: Q. on marking __initdata
Date: Mon, 5 Feb 2001 12:15:01 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a question (not a patch proposal):

Could
+/* # of MP IRQ source entries */
+struct mpc_config_intsrc mp_irqs[MAX_IRQ_SOURCES];

in arch/i386/kernel/mpparse.c (in 2.4.1-ac3; or in
arch/i386/kernel/io_apic.c in 2.4.1) be marked as
__initdata ?  If not, why not?  Or is __initdata
not needed on it for some reason (and if so, what
reason)?

Thanks,
~Randy_________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
