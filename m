Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129995AbRBSS3a>; Mon, 19 Feb 2001 13:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130828AbRBSS3U>; Mon, 19 Feb 2001 13:29:20 -0500
Received: from pompeiu.imar.ro ([193.226.4.7]:57732 "HELO pompeiu.imar.ro")
	by vger.kernel.org with SMTP id <S129995AbRBSS3D>;
	Mon, 19 Feb 2001 13:29:03 -0500
Date: Mon, 19 Feb 2001 20:29:24 +0200
From: Ionut Dumitrache <Ionut.Dumitrache@imar.ro>
To: linux-kernel@vger.kernel.org
Subject: support for i815 audio ?
Message-ID: <20010219202924.6160015318@pompeiu.imar.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


        Should this onboard audio work with the i810 driver, in 2.2.x
and 2.4.x ?
  The card is detected as ICH2, although the driver supports only ICH.

----
Intel 810 + AC97 Audio, version 0.17, 17:24:05 Feb 17 2001
PCI: Increasing latency timer of device 00:fd to 64
i810: Intel ICH2 found at IO 0xef00 and 0xe800, IRQ 9
ac97_codec: AC97 Audio codec, vendor id1: 0x4144, id2: 0x5360 (Analog
Devices AD1885)
i810_audio: Codec refused to allow VRA, using 48Khz only.
i810_audio: Found 1 audio device(s).
----

As seen above, playback is supported only for 48khz samples.

 If this is supposed to happen, is there a plan to support this
version as well ?

P.S. Please cc-me, i'm not subscribed to this list.
