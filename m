Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261284AbSI3T7W>; Mon, 30 Sep 2002 15:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261285AbSI3T7W>; Mon, 30 Sep 2002 15:59:22 -0400
Received: from mail.scram.de ([195.226.127.117]:47565 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S261284AbSI3T7V>;
	Mon, 30 Sep 2002 15:59:21 -0400
Date: Mon, 30 Sep 2002 10:04:16 +0200 (CEST)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@alpha.bocc.de
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
In-Reply-To: <20020930180732.GG13478@conectiva.com.br>
Message-ID: <Pine.LNX.4.44.0209301000260.1068-100000@alpha.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

> Yes, it is, this is fixed in Linus bk tree, snap_init has to be called after
> llc_init, this is the patch:

Thanks. This fixed it.

However, i still have problems with my ISA busmaster DMA token ring card
in the box.

http://www.cs.helsinki.fi/linux/linux-kernel/2002-10/0179.html still
applies to 2.5.39. After changing ISA_DMA_MASK, my Alpha is now running
2.5.39 :-)

Remaining issues:

- ATY frame buffer not working (black screen with jumpy cursor)
- ALSA doesn't compile (this seems to be cause by missing include here and
  there)

Cheers,
--jochen

