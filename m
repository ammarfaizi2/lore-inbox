Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131216AbQLHTRb>; Fri, 8 Dec 2000 14:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131773AbQLHTRW>; Fri, 8 Dec 2000 14:17:22 -0500
Received: from [194.212.165.105] ([194.212.165.105]:8204 "EHLO gate.suse.cz")
	by vger.kernel.org with ESMTP id <S131216AbQLHTRH>;
	Fri, 8 Dec 2000 14:17:07 -0500
Date: Fri, 8 Dec 2000 19:46:33 +0100 (MET)
From: Jaroslav Kysela <perex@suse.cz>
To: Pete Zaitcev <zaitcev@metabyte.com>
cc: Pavel Roskin <proski@gnu.org>, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: Re: [PATCH] for YMF PCI sound cards
In-Reply-To: <200012081831.KAA06813@ns1.metabyte.com>
Message-ID: <Pine.LNX.4.21.0012081945270.15912-100000@gate.suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Pete Zaitcev wrote:

> > +++ ./drivers/sound/ac97_codec.c	Thu Dec  7 11:00:44 2000
> > @@ -61,6 +61,7 @@
> >  } ac97_codec_ids[] = {
> >  	{0x414B4D00, "Asahi Kasei AK4540 rev 0", NULL},
> >  	{0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
> > +	{0x41445303, "Yamaha YMF????"          , NULL},
> 
> Are you sure it's correct? I am almost certain that no YMFxxx
> has on-chip AC97. I'd like to see a document that allows you
> the change quoted above.

It's Analog Device's AD1819 chip.

					Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
SuSE Linux    http://www.suse.com
ALSA project  http://www.alsa-project.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
