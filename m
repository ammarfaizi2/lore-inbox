Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279079AbRKICBb>; Thu, 8 Nov 2001 21:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279144AbRKICBV>; Thu, 8 Nov 2001 21:01:21 -0500
Received: from [208.129.208.52] ([208.129.208.52]:26884 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S279106AbRKICBH>;
	Thu, 8 Nov 2001 21:01:07 -0500
Date: Thu, 8 Nov 2001 18:09:29 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] scheduler cache affinity improvement for 2.4 kernels
In-Reply-To: <20011108173458.C14468@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.40.0111081752260.1501-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Nov 2001, Mike Fedyk wrote:

> > The MQ scheduler has the same roots of the proposed one but has a longest
> > fast path due the try to make global scheduling decisions at every
> > schedule.
>
> Ahh, so that's why it hasn't been adopted...

Changing the scheduler is not easy ( not to code patches but to make
everyone agree on the need of changing it ) and as i already said, it's
easier to force my cat to have a bath instead of Linus to change the
scheduler :)


> > I'm in contact ( close contact coz we're both in Beaverton :) ) with IBM
> > guys to have the two scheduler tested on bigger machines if the proposed
> > scheduler will give some fruit.
> >
>
> >From what I've seen, it probably will...
>
> I hope something like this will go into 2.5...
>
> What do other unixes do in this case?  Are there any commercial Unixes that
> have loose affinity like linux currently does?  What about NT?

I can't say about NT.
I've tried a "cvs checkout" from cvs.microsoft.com but the running server
( Nimda-CVS running on port 2401 ) said me that, although I've full
read/write access on the repository, the server is busy scanning port 80s :)




- Davide


