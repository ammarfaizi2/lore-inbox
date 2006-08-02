Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWHBXF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWHBXF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 19:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWHBXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 19:05:59 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:9402 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932327AbWHBXF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 19:05:58 -0400
Date: Thu, 3 Aug 2006 01:05:43 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       kernel list <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Subject: Re: driver for thinkpad fingerprint sensor
Message-ID: <20060802230543.GA15561@elf.ucw.cz>
References: <20060802203925.GA13899@elf.ucw.cz> <20060802214126.GA22928@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060802214126.GA22928@atjola.homenet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Here's GPLed driver for thinkpad fingerprint sensor. It is in
> > userspace -- for now, but it is so simple it could be easily moved
> > into kernel (everything is done in hardware).
> > 
> > Questions are:
> > 
> > *) should it be kernel or userspace?
> > 
> > *) can someone test it/fix it on X41 and similar models? It works okay
> > on x60.
> 
> I just gave it a try on my T43 (2668-WUM), works well if I swipe my
> finger correctly, ends up in a loop otherwise (at least I guess it's bad
> finger swiping).

Nice to know it works for someone. Yes, it sometimes ends up in a loop
if I do something "funny". (But I guess error handling during _enroll_
is not that critical :-).

> Some outputs from thinkfinger follow.

Thanks.

One more question: Does someone still have original Windoze that came
with x60? I think I've seen their software showing me my own
fingerprints. Can someone confirm/deny that? Getting pictures of
finterprints would be nice -- we would not have to rely on proprietary
fingerprint format only known to scanner vendor...

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
