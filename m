Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRJ2KlZ>; Mon, 29 Oct 2001 05:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279142AbRJ2KlF>; Mon, 29 Oct 2001 05:41:05 -0500
Received: from erasmus.jurri.net ([62.236.96.196]:58811 "EHLO
	oberon.erasmus.jurri.net") by vger.kernel.org with ESMTP
	id <S279113AbRJ2KlC>; Mon, 29 Oct 2001 05:41:02 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.4.13-acX: NM256 hangs at boot
From: Samuli Suonpaa <suonpaa@iki.fi>
Date: 29 Oct 2001 12:41:35 +0200
Message-ID: <87y9luohi8.fsf@puck.erasmus.jurri.net>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been succesfully using NM256-soundmodule on my Dell Latitute
CPtC400 until I upgraded from kernel 2.4.12-ac5 to 2.4.13-ac3. Now the
system hangs at boot - or to be more precise, right after boot when
modutils try to load nm256_audio.o as instructed in /etc/modules.
Lockup is complete, even power-button doesn't work so I have to remove
battery and power-cord to get the machine shut down. I have
APM-support compiled in, no ACPI.

NM256 is PCI-based, so I checked whether CONFIG_HOTPLUG_PCI would have
any effect. It didn't.

Exactly the same thing happens with 2.4.13-ac4.

If I compile the kernel without sound-support, everything works just
fine.

Has anyone had similar problems? What additional info should I
produce? 

Suonp‰‰...
