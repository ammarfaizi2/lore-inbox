Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143779AbRAHPqF>; Mon, 8 Jan 2001 10:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143863AbRAHPpz>; Mon, 8 Jan 2001 10:45:55 -0500
Received: from ns.caldera.de ([212.34.180.1]:4361 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S143779AbRAHPpo>;
	Mon, 8 Jan 2001 10:45:44 -0500
Date: Mon, 8 Jan 2001 16:45:37 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Martin Laberge <mlsoft@videotron.ca>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 - sndstat not present
Message-ID: <20010108164536.A4257@caldera.de>
Mail-Followup-To: Martin Laberge <mlsoft@videotron.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <200101081518.QAA01381@ns.caldera.de> <3A59DD1F.E1CB0B0F@videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <3A59DD1F.E1CB0B0F@videotron.ca>; from mlsoft@videotron.ca on Mon, Jan 08, 2001 at 10:30:39AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 10:30:39AM -0500, Martin Laberge wrote:
> the reference to sndstat and /proc/sound was found in
> 
> drivers/sound/soundcard.c

IIRC it is only in the changelogs - and I don't want to play Big Brother on
source files ...

> thanks for your lights on this topic...
> 
> is there nothing i can use anymore to check existence of sound drivers
> in kernel...

Nothing sound specific, no.

> 
> these informations were very valuables when i was configuring my cards
> for the first time... sometimes the driver loaded but do not appeared in
> sndstat
> then i was able to change my configuration according to what i see in
> sndstat...

The problem is that the PCI drivers don't support this feature anymore.
Not sure wether ALSA, which will bring a unified (in-kernel) sound-API
again has such a feature.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
