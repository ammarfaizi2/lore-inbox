Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbUK3Ac0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbUK3Ac0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 19:32:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbUK3Ac0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 19:32:26 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37825
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261890AbUK3AcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 19:32:07 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: ncunningham@linuxmail.org
Subject: Re: Suspend 2 merge: 49/51: Checksumming
Date: Mon, 29 Nov 2004 18:30:33 -0500
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1101292194.5805.180.camel@desktop.cunninghams> <200411290455.10318.rob@landley.net> <1101767472.4343.439.camel@desktop.cunninghams>
In-Reply-To: <1101767472.4343.439.camel@desktop.cunninghams>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411291830.33885.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 November 2004 07:24 pm, Nigel Cunningham wrote:
> Hi.
>
> On Mon, 2004-11-29 at 20:55, Rob Landley wrote:
> > On Wednesday 24 November 2004 08:02 am, Nigel Cunningham wrote:
> > > A plugin for verifying the consistency of an image. Working with kdb,
> > > it can look up the locations of variations. There will always be some
> > > variations shown, simply because we're touching memory before we get
> > > here and as we check the image.
> >
> > A while back I suggested checking the last mount time of the mounted
> > local filesystems as a quick and dirty sanity check between loading the
> > image and unfreezing all the processes.  (Since a read-only mount
> > shouldn't touch this, triggering swsusp resume from userspace after
> > prodding various hardware shouldn't cause a major problem either...) 
> > Does that sound like a good idea?
>
> If I recall correctly, someone replied that even a read only mount under
> one filesystem (XFS? Not sure), would replay the journal, so it wasn't a
> goer.

You could always special case the broken one until they fix it... :)

> > Haven't had time to look into it myself, though.  (Just recently got time
> > enough to bang on busybox again.  Somewhere around 2.6.7, software
> > suspend stopped working for me and I haven't even had a chance to track
> > _that_ down yet.  Hopefully fixed in 2.6.9 or 2.6.10, I haven't played
> > with it recently...)
>
> If you mean suspend2, I might be able to help if given more info.

Nah, the one that's built in.  I'll try it again when I upgrade to 2.6.10 in a 
few days.

> Regards,
>
> Nigel

Rob
