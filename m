Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269775AbRHNEJc>; Tue, 14 Aug 2001 00:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269786AbRHNEJW>; Tue, 14 Aug 2001 00:09:22 -0400
Received: from femail28.sdc1.sfba.home.com ([24.254.60.18]:63382 "EHLO
	femail28.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269775AbRHNEJD>; Tue, 14 Aug 2001 00:09:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Adrian Cox <adrian@humboldt.co.uk>, tegeran@home.com
Subject: Re: via82cxxx_audio driver bug?
Date: Mon, 13 Aug 2001 21:09:00 -0700
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <01081307194201.00276@c779218-a> <3B77EFE6.9020106@humboldt.co.uk>
In-Reply-To: <3B77EFE6.9020106@humboldt.co.uk>
MIME-Version: 1.0
Message-Id: <01081321090000.00204@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 August 2001 08:19 am, Adrian Cox wrote:
> Nicholas Knight wrote:
> > I just sent email to the maintainer of the via82cxxx_audio driver
> > regarding this bug, hopefully I'll hear back from him soon, but I'd
> > also like to hear from anyone else who has used and/or hacked at this
> > driver, and if they've seen XMMS or other audio applications with
> > access to /dev/mixer have strange, temporarily lockups when not in
> > root/realtime priority. I've yet to be able to test this with other
> > audio applications besides XMMS.
>
> Are you using 2.4.7 or 2.4.8? Those kernels have new code to talk to
> the AC97 codec, which cures lockups on some boards.

Both, and previous kernels back to 2.4.3 have also shown this.
I also replaced via82cxxx_audio.c in 2.4.8 with the latest (.15, 2.4.8 is 
".14b") and recompiled, and the problem persists.

Keep in mind, this isn't a *total* lockup, it's a problem of the UI in 
XMMS and other applications becoming unresponsive. Audio skips from this 
are rare but not unknown to me.
