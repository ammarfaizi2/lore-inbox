Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143672AbRAHPTM>; Mon, 8 Jan 2001 10:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143866AbRAHPTD>; Mon, 8 Jan 2001 10:19:03 -0500
Received: from ns.caldera.de ([212.34.180.1]:44552 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S143672AbRAHPSw>;
	Mon, 8 Jan 2001 10:18:52 -0500
Date: Mon, 8 Jan 2001 16:18:44 +0100
Message-Id: <200101081518.QAA01381@ns.caldera.de>
From: Christoph Hellwig <hch@caldera.de>
To: mlsoft@videotron.ca (Martin Laberge)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 - sndstat not present
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3A59CD57.6FA72934@videotron.ca>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A59CD57.6FA72934@videotron.ca> you wrote:
> i installed 2.4.0 last week and all worked well on my amd-K6-350
> i use a cheap sound card since 2.0.36 and it always worked well too.
> it work well now in 2.4.0, BUT , /dev/sndstat report me <no such file or
> directory>
> and /proc/sound (as noted in documentation) does not exist...

Please read Documentation/sound/NEWS.
Where in the documentation is /proc/sound still noted?

> the sound work well, but i cant verify the existence of the driver with
> sndstat anymore
>
> could someone tell me if i should have done some additionnal
> configuration to see
> appear the /proc/sound or to enable /dev/sndstat...

No - it's simply gone.

> maybe is it another method now in 2.4 to see the sound status...

cat foo.au > /dev/audio

> Best Wishes to all of you for the new year...

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
