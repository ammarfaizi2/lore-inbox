Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310242AbSBRI1b>; Mon, 18 Feb 2002 03:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310247AbSBRI1M>; Mon, 18 Feb 2002 03:27:12 -0500
Received: from gate.perex.cz ([194.212.165.105]:58374 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S310242AbSBRI1C>;
	Mon, 18 Feb 2002 03:27:02 -0500
Date: Mon, 18 Feb 2002 09:26:45 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: Andrey Panin <pazke@orbita1.ru>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ISAPNP support in ALSA (2.5.5-pre1) is broken
In-Reply-To: <20020218072701.GA4598@pazke.ipt>
Message-ID: <Pine.LNX.4.31.0202180925340.505-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Andrey Panin wrote:

> Hi all,
>
> ISA PnP support in 2.5.5-pre1 ALSA modules is broken.
> 1) it uses __ISAPNP__ without including linux/isapnp.h,
> 2) it uses isapnp_dev and isapnp_card sturctures which
> are not declared anywhere.

Thanks. I've applied your patch with minor modifications to our
CVS repository.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com

