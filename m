Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276709AbRKJHiu>; Sat, 10 Nov 2001 02:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279505AbRKJHik>; Sat, 10 Nov 2001 02:38:40 -0500
Received: from ws-002.ray.fi ([193.64.14.2]:59802 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S276709AbRKJHiW>;
	Sat, 10 Nov 2001 02:38:22 -0500
Date: Sat, 10 Nov 2001 09:35:45 +0200 (EET)
From: Tommi Kyntola <lk@ts.ray.fi>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Anthony Campbell <a.campbell@doctors.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Total lockup with 2.4.14
In-Reply-To: <20011109125730.B446@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0111100933470.24163-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I've had 3 total lockups with kernel 2.4.12 and now one with 2.4.14.
> > 
> > I was online at the time, using Acroread on this occasion. No key would
> > work, nor would the mouse.
> > 
> > This doesn't seem to happen with the Alan Cox patches, so perhaps it is
> > something to do with VM.
> > 
> 
> Don't assume that.
> 
> The -ac patch includes many more things than just the previous VM.
> 
> You should include the Oops, if it did oops.
> 
> Also, you should include your .config, and a "lspci -vv" of the affected
> system.

It would also make sense to make sure it's in fact a kernel lock up.
>From time to time X may lock up _but_ the machine pings and you
can gain access via ssh/telnet and try to fix it by shutting down
X from there...

  Tommi "Kynde" Kyntola      
     /* A man alone in the forest talking to himself and 
        no women around to hear him. Is he still wrong?  */

