Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRBSSv6>; Mon, 19 Feb 2001 13:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129619AbRBSSvs>; Mon, 19 Feb 2001 13:51:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32786 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129609AbRBSSvf>; Mon, 19 Feb 2001 13:51:35 -0500
Subject: Re: support for i815 audio ?
To: Ionut.Dumitrache@imar.ro (Ionut Dumitrache)
Date: Mon, 19 Feb 2001 18:51:43 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010219202924.6160015318@pompeiu.imar.ro> from "Ionut Dumitrache" at Feb 19, 2001 08:29:24 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14UvPV-0004Bw-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ac97_codec: AC97 Audio codec, vendor id1: 0x4144, id2: 0x5360 (Analog
> Devices AD1885)
> i810_audio: Codec refused to allow VRA, using 48Khz only.
> i810_audio: Found 1 audio device(s).
> 
> As seen above, playback is supported only for 48khz samples.

If the codec only supports 48Khz samples then so be it. We support that but
its up to the applications to honour the errors they get setting other
speeds.
