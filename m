Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWEaIJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWEaIJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 04:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWEaIJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 04:09:42 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964838AbWEaIJl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 04:09:41 -0400
Date: Wed, 31 May 2006 10:08:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "D. Hazelton" <dhazelton@enter.net>
Cc: Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060531080847.GB1585@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <21d7e9970605301601t37f8d3ddwaf4a900ed8997fdf@mail.gmail.com> <9e4733910605301627t2f28db08vf58c78e2656b7047@mail.gmail.com> <200605302314.25957.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200605302314.25957.dhazelton@enter.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Actually the suspend/resume has to be in userspace, X just re-posts
> > > the video ROM and reloads the registers... so the repost on resume has
> > > to happen... so some component needs to be in userspace..
> >
> > I'd like to see the simple video POST program get finished. All of the
> > pieces are lying around. A key step missing is to getting klibc added
> > to the kernel tree which is being worked on.
> 
> True. But how long is it going to be before klibc is merged?

It is in -mm tree just now. Just work against -mm tree, it is tree
you'll need to merge against, anyway.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
