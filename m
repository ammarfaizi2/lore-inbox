Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291607AbSBHPKd>; Fri, 8 Feb 2002 10:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291605AbSBHPJl>; Fri, 8 Feb 2002 10:09:41 -0500
Received: from mailhub.dartmouth.edu ([129.170.16.6]:38673 "EHLO
	mailhub.Dartmouth.EDU") by vger.kernel.org with ESMTP
	id <S291600AbSBHPJ0>; Fri, 8 Feb 2002 10:09:26 -0500
X-Disclaimer: This message was received from outside Dartmouth's BlitzMail system.
Date: Fri, 08 Feb 2002 10:09:23 -0500
From: "Joseph L. Hill" <joseph.l.hill@Dartmouth.EDU>
To: linux-kernel@vger.kernel.org
Subject: i810_audio driver
Message-ID: <18090000.1013180963@localhost>
X-Mailer: Mulberry/2.2.0b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,


I have a linux-works 'nano II' server running RedHat 7.2 with the errata 
kernel (2.4.9-21). I am using this box an an irlp node but can not get any 
audio out of the sound card.

dmesg output:
i810: Intel ICH 82801AA found at IO 0xd000 and 0xd400, IRQ 11
i810_audio: Audio Controller supports 2 channels.
ac97_codec: AC97 Audio codec, id: 0x4144:0x5348 (Analog Devices AD1881A)
i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's not 
present), total channels = 2
ac97_codec: AC97 Modem codec, id: 0x5349:0x4c21 (Unknown)
i810_audio: timed out waiting for codec 1 analog ready


lsmods:
Module                  Size  Used by
irlp-port               1216   3
i810_audio             20768   0  (autoclean)
ac97_codec              9504   0  (autoclean) [i810_audio]
soundcore               4452   2  (autoclean) [i810_audio]
autofs                 11556   0  (autoclean) (unused)
8139too                13120   1
usb-uhci               21668   0  (unused)
usbcore                51808   1  [usb-uhci]
ext3                   62592   2
jbd                    41092   2  [ext3]

Any suggestions much appreciated, please cc joseph.l.hill@dartmouth with 
your reply.

Thank you for you time.
-joe



