Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWHBOtL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWHBOtL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 10:49:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWHBOtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 10:49:11 -0400
Received: from eurogra4543-2.clients.easynet.fr ([212.180.52.86]:55519 "HELO
	briare1.heliogroup.fr") by vger.kernel.org with SMTP
	id S1750916AbWHBOtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 10:49:10 -0400
From: Hubert Tonneau <hubert.tonneau@fullpliant.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.18-rc3
Date: Wed, 02 Aug 2006 18:35:26 GMT
Message-ID: <06AZVN211@briare1.heliogroup.fr>
X-Mailer: Pliant 96
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
>
> Do you really get Oops with 2.6.17-final, too?
> AFAIK, there was a bug in the early 2.6.17-rc regarding OSS emulation,
> but it got fixed in the later rc.

I confirm that the only oops I got was with 2.6.17-rc1

> The behavior of invalid O_* flag seems incompatible with the older
> version.  Although I don't think it's totally wrong behavior, surely
> better to keep the compatibility.  The patch below should fix it.

I don't care: I have changed my player.
I also tend to agree that opening /dev/dsp read write was not a good
idea, so I would not criticise the new behaviour.

Each version of Linux 2.6 tend to break some softwares due to subtil
changes. What is bad is that these changes tend to be not announced,
but on the other hand the kernel mailing list is very responsive,
so all in all it might be a reasonable way to go.

