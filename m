Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVCBNLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVCBNLf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 08:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVCBNLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 08:11:34 -0500
Received: from gate.perex.cz ([82.113.61.162]:10369 "EHLO mail.perex.cz")
	by vger.kernel.org with ESMTP id S262285AbVCBNLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 08:11:33 -0500
Date: Wed, 2 Mar 2005 14:01:41 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: smartlink alsa modem problem in 2.6.11
In-Reply-To: <200503021354.38603.cijoml@volny.cz>
Message-ID: <Pine.LNX.4.58.0503021358290.1745@pnote.perex-int.cz>
References: <200503021354.38603.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Michal Semler wrote:

> Hi,
> 
> I tried use snd_intel8x0m  with smartlink modem, but without success:

> Mar  2 13:49:37 notas kernel: codec_semaphore: semaphore is not ready [0x1][0x701300]
> Mar  2 13:49:37 notas kernel: codec_write 1: semaphore is not ready for 

It's known bug:

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=890

Have you tried to load "snd-intel8x0m and snd-intel8x0" modules in 
opposite order? Anyway, further discussion should go to this bug
report...

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs
