Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbRDGSpw>; Sat, 7 Apr 2001 14:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129478AbRDGSpm>; Sat, 7 Apr 2001 14:45:42 -0400
Received: from rigel.cs.pdx.edu ([131.252.208.59]:9102 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id <S129408AbRDGSpe>;
	Sat, 7 Apr 2001 14:45:34 -0400
Date: Sat, 7 Apr 2001 11:45:30 -0700 (PDT)
From: Naren Devaiah <naren@cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Subject: i810_audio.c: Clicks while playing audio
Message-ID: <Pine.GSO.4.21.0104071130340.7196-100000@spica.cs.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a HP Vectra VL 400 with a i815 motherboard playing a .wav file (haven't
tried anything else) causes the sound to be played with a lot of periodic
clicks. 
The kernel is 2.4.3
dmesg shows:
Intel 810 + AC97 Audio, version 0.01, 17:25:00 Apr  6 2001
PCI: Enabling device 00:1f.5 (0000 -> 0001)
PCI: Found IRQ 9 for device 00:1f.5
PCI: The same IRQ used for device 00:1f.3
PCI: Setting latency timer of device 00:1f.5 to 64
i810: Intel ICH 82801AA found at IO 0x1300 and 0x1200, IRQ 9
ac97_codec: AC97 Audio codec, id: 0x4352:0x5934 (Cirrus Logic CS4299)
i810_audio: 9568 bytes in 50 milliseconds
i810_audio: DMA overrun on send
i810_audio: DMA overrun on send

lsmod show:
root@darkstar:~# lsmod
Module                  Size  Used by
i810_audio             14084   0
ac97_codec              7908   0  [i810_audio]


My question is: What does "DMA overrun on send" mean?


Regards,
Naren



