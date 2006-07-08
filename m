Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWGHAE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWGHAE6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 20:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbWGHAE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 20:04:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52411 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932422AbWGHAE5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 20:04:57 -0400
Date: Sat, 8 Jul 2006 02:04:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: suspend2-devel@lists.suspend2.net, Olivier Galibert <galibert@pobox.com>,
       grundig <grundig@teleline.es>, Avuton Olrich <avuton@gmail.com>,
       jan@rychter.com, linux-kernel@vger.kernel.org
Subject: Re: [Suspend2-devel] Re: swsusp / suspend2 reliability
Message-ID: <20060708000440.GC1700@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz> <20060707215656.GA30353@dspnet.fr.eu.org> <20060707232523.GC1746@elf.ucw.cz> <200607080933.12372.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607080933.12372.ncunningham@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2006-07-08 09:33:00, Nigel Cunningham wrote:
> Hi.
> 
> On Saturday 08 July 2006 09:25, Pavel Machek wrote:
> > > > So what Pavel wants can be
> > > > translated as 'please use already merged code, it can already do what
> > > > you want without further changing kernel'.
> > >
> > > Like we'd want to use unreviewed, extremely new and risky code for
> > > something that happily destroy filesystems.
> >
> > You can either use suspend2 (14000 lines of unreviewed kernel code,
> > old) or uswsusp (~500 lines of reviewed kernel code, ~2000 lines of
> > unreviewed userspace code, new).
> 
> I was going to keep quiet, but I have to say this: If Suspend2 can rightly be 
> called unreviewed code, it's only because you've been too busy flaming etc to 
> give it serious review. Personally, though, I don't think it's right to call 
> it unreviewed. I've had and applied feedback from lots of people over time 
> (hch, Rafael, Pekka(sp?), Nick, Con and Hugh to name just a few). If they 
> weren't reviewing the code, what were they doing?

Well, you are right that Rafael did some quite serious reviewing of
latest incarnation... OTOH you got some pretty big comments ("may not
use /proc") that were not included, yet (and will need big changes),
so it is not really reviewed, either. (Certainly swsusp in-kernel code
got more reviewing over the years).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
