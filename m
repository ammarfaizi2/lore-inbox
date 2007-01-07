Return-Path: <linux-kernel-owner+w=401wt.eu-S932562AbXAGO4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932562AbXAGO4j (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 09:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbXAGO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 09:56:39 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:3589 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932562AbXAGO4i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 09:56:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mXJKW1y79NDKUohnUzPdMsY3mSevDKjszpk33a5Tq9fNEZIP6pDgetMGAqsgBR0wcZrK+OhLpOrQR/E2HqVR289fmgrik1FXvdZ/1psehqULy4sYN79VwBLgef6Vk9+dKtTIJx4meDpMa9+D2NiVYdEw6+N32xFc+Ic5rSmjpzE=
Message-ID: <b637ec0b0701070656g5e276ae4ie39eb45d002260c@mail.gmail.com>
Date: Sun, 7 Jan 2007 09:56:36 -0500
From: "Fabio Comolli" <fabio.comolli@gmail.com>
To: "Pierre Ossman" <drzeus-mmc@drzeus.cx>, "Alex Dubov" <oakad@yahoo.com>
Subject: Re: [PATCH 1/1] MMC: new version of the TI Flash Media card reader driver
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <4563F14C.9060100@drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <281931.6630.qm@web36709.mail.mud.yahoo.com>
	 <4563F14C.9060100@drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.
I just wanted to let you know that I tested the version found in
git-mmc.patch (from latest -mm kernel) with kernel version
2.6.20-rc3-g6a4306b3 (2 or 3 days ago Linus' GIT tree).

No problems so far: the driver seems pretty stable: it survived
various suspend-to-ram and suspend-to-disk attempts without a single
problem, even with the card inserted and filesystem mounted.

Tests were performed with a 2GB SD card, a 512MB MMC card and with a
256 mini-SD.

Best regards,
Fabio





On 11/22/06, Pierre Ossman <drzeus-mmc@drzeus.cx> wrote:
> Alex Dubov wrote:
> > I know that the patch is too big, but I have no way to split it up. Basically, I've changed so
> > many things (I had quite a few problems with interrupts after suspend/resume) that it can be
> > regarded as a brand new driver. My SVN became somewhat messy too.
> >
> > I can post the driver in it full (non-diff) form or as a 4 per-file diffs, but I have no way to
> > split it up into per-issue form (except for issues 3 and 5, which are one-liners).
> >
>
> That's a start. But 4 sounds like it could be broken out with some work.
>
> I'm not saying it's trivial to break this apart, but it is something
> that needs to be done. At the very least the commit messages need to
> reflect what is changed and why.
>
> See it as practice as this is an issue you will be hit by now and then
> as a kernel developer. :)
>
> Rgds
> --
>      -- Pierre Ossman
>
>   Linux kernel, MMC maintainer        http://www.kernel.org
>   PulseAudio, core developer          http://pulseaudio.org
>   rdesktop, core developer          http://www.rdesktop.org
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
