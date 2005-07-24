Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261367AbVGXPLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbVGXPLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 11:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261370AbVGXPLM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 11:11:12 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:4562 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261367AbVGXPLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 11:11:08 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.12.3] dyntick 050610-1 breaks makes S3 suspend
Date: Sun, 24 Jul 2005 17:11:22 +0200
User-Agent: KMail/1.8.1
Cc: Pavel Machek <pavel@ucw.cz>, Christian Hesse <mail@earthworm.de>,
       Tony Lindgren <tony@atomide.com>
References: <200507231435.05015.lkml@kcore.org> <200507231451.04630.mail@earthworm.de> <20050724142318.GA1778@elf.ucw.cz>
In-Reply-To: <20050724142318.GA1778@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507241711.23217.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 July 2005 16:23, Pavel Machek wrote:
> Hi!
>
> > > I recently tried out dyntick 050610-1 against 2.6.12.3, works great, it
> > > actually makes a noticeable difference on my laptop's battery life. I
> > > don't have hard numbers, lets just say that instead of the usual ~3
> > > hours i get out of it, i was ~4 before it started nagging, usual use
> > > pattern at work.
> > >
> > > The only gripe I have with it that it stops S3 from working. If the
> > > patch is compiled in the kernel, it makes S3 suspend correctly, but
> > > resuming goes into a solid hang (nothing get's it back alive, have to
> > > keep the powerbutton for ~5 secs to shutdown the system)
> > >
> > > Anything I could test? The logs don't give anything useful..
> >
> > I reported this some time ago [1], but there's no sulution so far...
> >
> > [1] http://groups.google.com/groups?selm=4b4NI-7mJ-9%40gated-at.bofh.it
>
> Does it also break if swsusp? Does it break if you replace enter sleep
> function with some kind of dummy functions? (Or perhaps S1 is enough
> for this test?)

I have only tried with S3.. how do I test with S1?

Jan

-- 
YOW!!  I'm in a very clever and adorable INSANE ASYLUM!!
