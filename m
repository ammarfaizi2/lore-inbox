Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269954AbRHMH5b>; Mon, 13 Aug 2001 03:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269968AbRHMH5V>; Mon, 13 Aug 2001 03:57:21 -0400
Received: from ns.ooc.de ([213.144.20.2]:12045 "HELO mail.ooc.de")
	by vger.kernel.org with SMTP id <S269954AbRHMH5M>;
	Mon, 13 Aug 2001 03:57:12 -0400
Date: Mon, 13 Aug 2001 09:53:36 +0200
From: Uwe Seimet <us@orbacus.com>
To: linux-kernel@vger.kernel.org
Subject: Bug in esssolo1.c, kernel 2.4.7 and 2.4.8
Message-ID: <20010813095336.A934@duplo.ooc.de>
Reply-To: us@ooc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

with kernel 2.4.7 and 2.4.8 you get this error message when running make
modules_install:

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.4.8; fi
depmod: *** Unresolved symbols in
/lib/modules/2.4.8/kernel/drivers/sound/esssolo1.o
depmod:         gameport_register_port
depmod:         gameport_unregister_port

These symbols seem to be missing in esssolo1.c. With kernel 2.4.6 and older
I did not get this error.

Best regards,   Uwe

-- 
----------------------------------------------------------------------------
 Dr. Uwe Seimet                                    mailto:us@iona.com
 IONA - Total Business Integration(tm)             http://www.orbacus.com
