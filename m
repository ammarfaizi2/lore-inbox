Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279157AbRJ2Kvp>; Mon, 29 Oct 2001 05:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279178AbRJ2Kvg>; Mon, 29 Oct 2001 05:51:36 -0500
Received: from mail110.mail.bellsouth.net ([205.152.58.50]:32369 "EHLO
	imf10bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279157AbRJ2KvY>; Mon, 29 Oct 2001 05:51:24 -0500
Message-ID: <3BDD34D3.B7ABE033@mandrakesoft.com>
Date: Mon, 29 Oct 2001 05:52:03 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Samuli Suonpaa <suonpaa@iki.fi>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.13-acX: NM256 hangs at boot
In-Reply-To: <87y9luohi8.fsf@puck.erasmus.jurri.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuli Suonpaa wrote:
> 
> I've been succesfully using NM256-soundmodule on my Dell Latitute
> CPtC400 until I upgraded from kernel 2.4.12-ac5 to 2.4.13-ac3. Now the
> system hangs at boot - or to be more precise, right after boot when
> modutils try to load nm256_audio.o as instructed in /etc/modules.
> Lockup is complete, even power-button doesn't work so I have to remove
> battery and power-cord to get the machine shut down. I have
> APM-support compiled in, no ACPI.

Does backing out this patch fix things?

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patches/2.4.13/nm256-ac97-update-2.4.13.ac1.patch.gz


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

