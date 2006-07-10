Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422797AbWGJUH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422797AbWGJUH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWGJUH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:07:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:55179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422797AbWGJUH7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:07:59 -0400
Date: Mon, 10 Jul 2006 22:07:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: git, hardlinks and backups
Message-ID: <20060710200728.GB2246@elf.ucw.cz>
References: <20060710195727.GA2246@elf.ucw.cz> <20060710200501.GB30678@ojjektum.uhulinux.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710200501.GB30678@ojjektum.uhulinux.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I know this may be stupid, but...
> > 
> > I'm backing up my linux kernel trees, and found out that backup (done
> > by rsync) is twice as big as original. That's quite bad... it is
> > because git uses hardlinks heavily but rsync can't preserve them.
> > 
> > I'm pretty sure someone hit this before... what is the trick?
> 
> The -H option of rsync?

Okay, I was blind, sorry.

For those who made same mistake... utility called freedups should be
able to clean that up.
								Pavel


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
