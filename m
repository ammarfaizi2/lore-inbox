Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263412AbTI2N7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 09:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263420AbTI2N7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 09:59:33 -0400
Received: from gate.perex.cz ([194.212.165.105]:44763 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263412AbTI2N7b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 09:59:31 -0400
Date: Mon, 29 Sep 2003 15:58:37 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Florin Iucha <florin@iucha.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030929132355.GA1206@iucha.net>
Message-ID: <Pine.LNX.4.53.0309291556490.1362@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
 <20030929132355.GA1206@iucha.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, Florin Iucha wrote:

> On Sat, Sep 27, 2003 at 06:27:35PM -0700, Linus Torvalds wrote:
> >
> [snip]
> > arm, s390, ia64, x86-64, and ppc64 updates. USB, pcmcia and i2c stuff. And
> > a fair amount of janitorial.
>
> I can no longer select my soundcard: In test5 it was configured by
> CONFIG_SND_CS46XX! This option is no longer available in test6 (make
> menuconfig does not offer me the opportunity).
>
> It happened between test5-bk11 (option set/module build) and bk13
> (option not available).
>
> Please, give my sound option back!

The driver is still there. As workaround, you can enable GAMEPORT or kill
all occurences of string '&& GAMEPORT' in sound/pci/Kconfig (it's the real
fix).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
