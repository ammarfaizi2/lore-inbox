Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287148AbSAGV1m>; Mon, 7 Jan 2002 16:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287139AbSAGV1d>; Mon, 7 Jan 2002 16:27:33 -0500
Received: from ns.caldera.de ([212.34.180.1]:6867 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287148AbSAGV1U>;
	Mon, 7 Jan 2002 16:27:20 -0500
Date: Mon, 7 Jan 2002 22:25:42 +0100
Message-Id: <200201072125.g07LPgE02318@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: abramo@alsa-project.org (Abramo Bagnara)
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jaroslav Kysela <perex@suse.cz>,
        sound-hackers@zabbo.net, linux-sound@vger.rutgers.edu,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [s-h] Re: ALSA patch for 2.5.2pre9 kernel
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3C39E6A0.34A88990@alsa-project.org>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C39E6A0.34A88990@alsa-project.org> you wrote:
> If you want to keep top level cleaner and avoid proliferation of entries
> we might have:
>
> subsys/sound
> subsys/sound/drivers
> subsys/net
> subsys/net/drivers

And what part of the kernel is no subsystem?
Your subsystem directory is superflous.

If, for some reason, we want to move all code in the kernel around
we should do it once and in a planned mannor.

Randomly introducing new and shiny naming schemes sucks.  badly.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
