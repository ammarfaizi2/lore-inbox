Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272239AbTGaAzP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272247AbTGaAzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:55:15 -0400
Received: from cm61.gamma179.maxonline.com.sg ([202.156.179.61]:26752 "EHLO
	amaryllis.anomalistic.org") by vger.kernel.org with ESMTP
	id S272239AbTGaAzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:55:11 -0400
Date: Thu, 31 Jul 2003 08:55:09 +0800
From: Eugene Teo <eugene.teo@eugeneteo.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: Eugene Teo <eugene.teo@eugeneteo.net>, Rahul Karnik <rahul@genebrew.com>,
       Stefano Rivoir <s.rivoir@gts.it>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
Message-ID: <20030731005509.GA11871@eugeneteo.net>
Reply-To: Eugene Teo <eugene.teo@eugeneteo.net>
References: <3F27817A.8000703@gts.it> <3F2861D3.4030703@genebrew.com> <20030731001336.GA725@eugeneteo.net> <200307311024.55830.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307311024.55830.kernel@kolivas.org>
X-Operating-System: Linux 2.6.0-test2-mm1-kj1+O11.2int
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<quote sender="Con Kolivas">
> On Thu, 31 Jul 2003 10:13, Eugene Teo wrote:
> > <quote sender="Rahul Karnik">
> >
> > > Stefano Rivoir wrote:
> > > >I'm experiencing hard rand lockups using kernel 2.6.0: they are not
> > > >predictable, nor I can find a way to reproduce them. They can occur
> > > >while working with an app, while browsing the fs (I use KDE) or
> > > >while resuming after the screensaver, or anything else. They can
> > > >occur after one hour or 15 minutes, and there's not any strange
> > > >"jerkiness" activity before, nor an intense disk work.
> > > >
> > > >After the hang, the disk starts working for a while, then I have
> > > >to reset w/button, and nothing is left on the various system logs.
> > > >
> > > >These hangs did not occur in 2.5 up to .75, but they come also
> > > >with 2.6.0-mm1 (and plain 2.6.0-t1). I had a doubt about the
> > > >soundcard, I've applied latest 0.9.6 alsa patch: the hangs are less
> > > >frequent but still there.
> > >
> > > Can you reproduce these hangs without the AGP and DRI modules loaded?
> >
> > I am encountering the same with 2.6.0-test2 but the
> > problem is, I patched it with a number of patches that
> > I am unable to determine which patches/changes causes
> > the random lockups. Actually I am suspecting it's O11.2int
> > because I wasn't having any problems with it prior to
> > this patch. will keep you guys updated.
> 
> O11.2 backs out changes to bring them back to the default, so it can't be that 
> specific patch. Also the original contributor describes the hangs with plain 
> 2.6.0-t1 which includes none of my patches.

I shall keep you guys updated. 

> Con
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
