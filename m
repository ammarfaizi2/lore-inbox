Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135533AbRDWTvi>; Mon, 23 Apr 2001 15:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135531AbRDWTv2>; Mon, 23 Apr 2001 15:51:28 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33287 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135528AbRDWTvZ>; Mon, 23 Apr 2001 15:51:25 -0400
Subject: Re: i810_audio broken?
To: pawel.worach@mysun.com
Date: Mon, 23 Apr 2001 20:53:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <32812371f1.371f132812@mysun.com> from "Pawel Worach" at Apr 23, 2001 08:15:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rmOZ-0000KJ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The i810 audio driver is broken on my Fujitsu Lifebook
> S-4546. All output is just noise. Here is a snip's from
> the kernel log.
> 
> Intel 810 + AC97 Audio, version 0.02, 19:41:16 Apr 23 2001
> PCI: Found IRQ 9 for device 00:00.1
> PCI: The same IRQ used for device 00:00.2
> PCI: The same IRQ used for device 00:13.1
> PCI: Setting latency timer of device 00:00.1 to 64
> i810: Intel 440MX found at IO 0x1cc0 and 0x1000, IRQ 9
> ac97_codec: AC97 Audio codec, id: 0x594d:0x4800 (Unknown)
> i810_audio: only 48Khz playback available

The dump looks fine. Its a cheap and cheeerful codec however by the look of it.
Make sure the applications you use properly handle 48Khz only audio. That
may be the problem or maybe not.

Also try the very latest kernels as a fair bit of work has been done on them

