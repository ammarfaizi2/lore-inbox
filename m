Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268875AbUHaVBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268875AbUHaVBt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269161AbUHaU5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:57:49 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:6534
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267650AbUHaU5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:57:10 -0400
Date: Tue, 31 Aug 2004 13:56:51 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, perex@suse.de
Subject: Re: ALSA update broke Sparc
Message-Id: <20040831135651.0da4dc5d.davem@davemloft.net>
In-Reply-To: <s5heklnyvmg.wl@alsa2.suse.de>
References: <20040827183646.1da2befc.davem@davemloft.net>
	<s5h4qmkkjl5.wl@alsa2.suse.de>
	<s5heklnyvmg.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 21:07:19 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> Although I still couldn't set up the sparc cross-compile environment,

There is a good one available somewhere, ask Andrew Morton for
pointers, he uses it.

> I fixed/updated the ALSA pcm layer.
> 
> David, could you try the attached patch?  With this, the problematic
> part will be disabled on sparc (it won't work on every architecture,
> anyway).

Generates lots of warnings like this:

  CC [M]  drivers/i2c/chips/smsc47m1.o
In file included from sound/pci/au88x0/au88x0.h:26,
                 from sound/pci/au88x0/au8820.c:2:
include/sound/pcm.h:960:1: warning: "SNDRV_PCM_INFO_MMAP" redefined
In file included from include/sound/pcm.h:26,
                 from sound/pci/au88x0/au88x0.h:26,
                 from sound/pci/au88x0/au8820.c:2:
include/sound/asound.h:264:1: warning: this is the location of the previous definition
