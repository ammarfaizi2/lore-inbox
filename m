Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272375AbTGaAU1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272377AbTGaAU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:20:27 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:43199
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272375AbTGaAU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:20:26 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Eugene Teo <eugene.teo@eugeneteo.net>, Rahul Karnik <rahul@genebrew.com>
Subject: Re: 2.6.0t2 Hangs randomly
Date: Thu, 31 Jul 2003 10:24:55 +1000
User-Agent: KMail/1.5.2
Cc: Stefano Rivoir <s.rivoir@gts.it>, linux-kernel@vger.kernel.org
References: <3F27817A.8000703@gts.it> <3F2861D3.4030703@genebrew.com> <20030731001336.GA725@eugeneteo.net>
In-Reply-To: <20030731001336.GA725@eugeneteo.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307311024.55830.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jul 2003 10:13, Eugene Teo wrote:
> <quote sender="Rahul Karnik">
>
> > Stefano Rivoir wrote:
> > >I'm experiencing hard rand lockups using kernel 2.6.0: they are not
> > >predictable, nor I can find a way to reproduce them. They can occur
> > >while working with an app, while browsing the fs (I use KDE) or
> > >while resuming after the screensaver, or anything else. They can
> > >occur after one hour or 15 minutes, and there's not any strange
> > >"jerkiness" activity before, nor an intense disk work.
> > >
> > >After the hang, the disk starts working for a while, then I have
> > >to reset w/button, and nothing is left on the various system logs.
> > >
> > >These hangs did not occur in 2.5 up to .75, but they come also
> > >with 2.6.0-mm1 (and plain 2.6.0-t1). I had a doubt about the
> > >soundcard, I've applied latest 0.9.6 alsa patch: the hangs are less
> > >frequent but still there.
> >
> > Can you reproduce these hangs without the AGP and DRI modules loaded?
>
> I am encountering the same with 2.6.0-test2 but the
> problem is, I patched it with a number of patches that
> I am unable to determine which patches/changes causes
> the random lockups. Actually I am suspecting it's O11.2int
> because I wasn't having any problems with it prior to
> this patch. will keep you guys updated.

O11.2 backs out changes to bring them back to the default, so it can't be that 
specific patch. Also the original contributor describes the hangs with plain 
2.6.0-t1 which includes none of my patches.

Con

