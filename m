Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271368AbRHUDBJ>; Mon, 20 Aug 2001 23:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271381AbRHUDA6>; Mon, 20 Aug 2001 23:00:58 -0400
Received: from hibernia.clubi.ie ([212.17.32.129]:25990 "HELO
	fogarty.jakma.org") by vger.kernel.org with SMTP id <S271368AbRHUDAi>;
	Mon, 20 Aug 2001 23:00:38 -0400
Date: Tue, 21 Aug 2001 04:02:47 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: <paul@fogarty.jakma.org>
To: Andi Kleen <ak@suse.de>
Cc: Richard Gooch <rgooch@ras.ucalgary.ca>, <tytso@mit.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
In-Reply-To: <oupk7zyqhw3.fsf@pigdrop.muc.suse.de>
Message-ID: <Pine.LNX.4.33.0108210353320.7402-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
X-Dumb-Filters: aryan marijuiana cocaine heroin hardcore cum pussy porn teen tit sex lesbian group
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 Aug 2001, Andi Kleen wrote:

> It is not that they are hard to fix; e.g. a $10 sound card
> with a noise generating circuit on input and a small daemon to feed
> /dev/audio to /dev/random can do it; but few people seem to know about

does this update the entropy count though? from previous 
discussions, i believe not, which iiuc means /dev/random will block 
just as frequently/infrequently irrespective of whether you feed 
stuff into /dev/random.

related: the i810 RNG has a driver, but it feeds data to /dev/random 
via a userspace daemon (rngd), so again entropy count is not changed.

kind of shame on the only mass-market RNG hardware out there.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Many people are unenthusiastic about their work.

