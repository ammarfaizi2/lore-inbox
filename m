Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280990AbRKOSor>; Thu, 15 Nov 2001 13:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKOSoh>; Thu, 15 Nov 2001 13:44:37 -0500
Received: from [216.80.8.1] ([216.80.8.1]:61193 "HELO mercury.prairiegroup.com")
	by vger.kernel.org with SMTP id <S280990AbRKOSo3>;
	Thu, 15 Nov 2001 13:44:29 -0500
Message-ID: <3BF40D17.4060501@prairiegroup.com>
Date: Thu, 15 Nov 2001 12:44:39 -0600
From: Martin McWhorter <m_mcwhorter@prairiegroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pete Zaitcev <zaitcev@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible Bug: 2.4.14 USB Keyboard
In-Reply-To: <3BF2DFBF.6090502@prairiegroup.com> <20011114145312.A6925@kroah.com> <mailman.1005834780.32418.linux-kernel2news@redhat.com> <200111151807.fAFI7XN30496@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete,

> ok, so no usbkbd, it seems. But still, do lsmod too, please.

[root@m_mcwhorter m_mcwhorter]# /sbin/lsmod
Module                  Size  Used by
emu10k1                49584   0  (autoclean)
sr_mod                 13968   0  (autoclean)
ac97_codec              9248   0  (autoclean) [emu10k1]
soundcore               3376   4  (autoclean) [emu10k1]
usbkbd                  2944   0  (unused)
autofs                  9184   1  (autoclean)
8139too                13152   1  (autoclean)
ipchains               31232   0
ide-scsi                7712   0
scsi_mod               86256   2  [sr_mod ide-scsi]
ide-cd                 26624   0
cdrom                  27328   0  [sr_mod ide-cd]
mousedev                3936   1
keybdev                 1728   0  (unused)
hid                    12576   0  (unused)
input                   3136   0  [usbkbd mousedev keybdev hid]
usb-uhci               21344   0  (unused)
usbcore                49184   1  [usbkbd hid usb-uhci]


Thanks for the help,
Martin

