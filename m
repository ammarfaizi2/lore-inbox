Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268901AbRHKX2K>; Sat, 11 Aug 2001 19:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268902AbRHKX2B>; Sat, 11 Aug 2001 19:28:01 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:24843 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S268901AbRHKX1r>; Sat, 11 Aug 2001 19:27:47 -0400
Subject: Re: [Emu10k1-devel] [PATCH] EMU10K1: Juha Rjola's AC3 Passthrough for
To: d.bertrand@ieee.org (Daniel Bertrand)
Date: Sun, 12 Aug 2001 00:29:42 +0100 (BST)
Cc: crimsun@email.unc.edu (Daniel T. Chen), linux-kernel@vger.kernel.org,
        emu10k1-devel@opensource.creative.com (emu10k1-devel)
In-Reply-To: <Pine.LNX.4.33.0108111518130.959-100000@kilrogg> from "Daniel Bertrand" at Aug 11, 2001 03:25:57 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ViCM-0003Xa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> For non-ac97 volume controls to work, the following needs to be added to
> ac97_codec.c (or else the codec gets reset as the module tries to write a
> volume to 0x00):

I disagree. If you have a non ac97 codec you shouldnt be calling into
ac97_codec.c in the first place

