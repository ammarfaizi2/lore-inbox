Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2Viz>; Fri, 29 Dec 2000 16:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130061AbQL2Vip>; Fri, 29 Dec 2000 16:38:45 -0500
Received: from f1j.dsl.xmission.com ([166.70.20.140]:21031 "EHLO
	f1j.dsl.xmission.com") by vger.kernel.org with ESMTP
	id <S129930AbQL2Vid>; Fri, 29 Dec 2000 16:38:33 -0500
Message-ID: <3A4CFD2D.F7DE3125@xmission.com>
Date: Fri, 29 Dec 2000 14:07:57 -0700
From: Frank Jacobberger <f1j@xmission.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: test13-pre5 + char-major-145??
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please help me explain why I'm getting the following
modprobe reply on boot up after kernel test13-pre5
loads:

modprobe: Can't locate module char-major-145

>From /usr/src/linux/Documentation/devices.txt

10 char        Non-serial mice, misc features
145 = /dev/hfmodem      Soundcard shortwave modem control {2.6}

My modules.conf:
-----------------------------------
alias eth0 rtl8139
alias eth1 rtl8139
alias parport_lowlevel parport_pc
alias sound-slot-0 emu10k1
alias usb-controller usb-uhci
-----------------------------------

What may be calling this? Any advice where to go ferreting?

Thanks,

Frank

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
