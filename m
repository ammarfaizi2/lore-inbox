Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313738AbSDHTIY>; Mon, 8 Apr 2002 15:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313739AbSDHTIX>; Mon, 8 Apr 2002 15:08:23 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:36495 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S313738AbSDHTIX>; Mon, 8 Apr 2002 15:08:23 -0400
From: David Lang <david.lang@digitalinsight.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Mon, 8 Apr 2002 12:06:44 -0700 (PDT)
Subject: Re: faster boots?
In-Reply-To: <Pine.LNX.3.95.1020408145504.1153A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0204081205330.27634-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Apr 2002, Richard B. Johnson wrote:

> On Mon, 8 Apr 2002, David Lang wrote:
>
> > watch out for the write cycle limits of your flash. they're pretty low
> > power (at least compared to anything mechanical) but if you're not careful
> > you can go through their write capability pretty fast.
> >
> > David Lang
> >
> >
> >
>
> Upon boot, you can mount a ram-disk off from /tmp. That will reduce
> the activity when using the usual editors, vi, vim, emacs, and pico,
> which all create temp files on /tmp.

yes, you also need to mount the flash with noatime. even then you want to
be careful about things like autosave.

David Lang
