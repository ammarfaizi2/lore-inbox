Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWGGXZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWGGXZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbWGGXZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:25:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20888 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932389AbWGGXZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:25:41 -0400
Date: Sat, 8 Jul 2006 01:25:23 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net
Subject: Re: swsusp / suspend2 reliability
Message-ID: <20060707232523.GC1746@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <44A14D3D.8060003@wasp.net.au> <20060627154130.GA31351@rhlx01.fht-esslingen.de> <20060627222234.GP29199@elf.ucw.cz> <m2k66qzgri.fsf@tnuctip.rychter.com> <3aa654a40607070819v1359fb69l5d617f029940cc0e@mail.gmail.com> <20060707180310.ef7186d7.grundig@teleline.es> <20060707174424.GA9913@dspnet.fr.eu.org> <20060707213916.GC5393@ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060707215656.GA30353@dspnet.fr.eu.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > So what Pavel wants can be
> > translated as 'please use already merged code, it can already do what
> > you want without further changing kernel'.
> 
> Like we'd want to use unreviewed, extremely new and risky code for
> something that happily destroy filesystems.

You can either use suspend2 (14000 lines of unreviewed kernel code,
old) or uswsusp (~500 lines of reviewed kernel code, ~2000 lines of
unreviewed userspace code, new).

Of course, you can also use swsusp (~2000 lines of reviewed kernel
code, pretty old) if stability matters to you more than graphical
progress bar.

I know what I'm picking, and I'm pretty sure I know what
mainline/distros will pick.

If you want to help, you are welcome to test/review any component. But
stop producing hot air.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
