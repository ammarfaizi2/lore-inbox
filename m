Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbWEaNf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbWEaNf0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 09:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWEaNf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 09:35:26 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18637 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S964979AbWEaNfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 09:35:25 -0400
Date: Wed, 31 May 2006 15:34:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Martin Mares <mj@ucw.cz>
Cc: Jon Smirl <jonsmirl@gmail.com>, Ondrej Zajicek <santiago@mail.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
Message-ID: <20060531133436.GA1875@elf.ucw.cz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <20060530223513.GA32267@localhost.localdomain> <9e4733910605301555o287cbd18i99c8813ca6592494@mail.gmail.com> <mj+md-20060531.064701.10737.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mj+md-20060531.064701.10737.atrey@ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 31-05-06 08:48:15, Martin Mares wrote:
> Hi!
> 
> > My thoughts are mixed on continuing to support text mode for anything
> > other than initial boot/install. Linux is all about multiple languages
> > and the character ROMs for text mode don't support all of these
> > languages.
> 
> On most servers, you don't need (and you don't want) anything like that.
> In such cases, everything should be kept simple.

Problem is: it messes up design for everyone else. (And no, Santiago,
most people are not using vgacon. Most people use vesafb these days,
because that's what allows whole screen to be used, not just 80x25).

fbcon is simple enough. Okay, vgacon may be useful for recovery, but
supporting accelerated 3D over vgacon is quite crazy.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
