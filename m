Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265647AbUBPP3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 10:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265641AbUBPP3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 10:29:07 -0500
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:5482 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265663AbUBPP3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 10:29:01 -0500
Date: Mon, 16 Feb 2004 09:28:53 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: Mark Watts <m.watts@eris.qinetiq.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Speaker static, vanishes with APIC
In-Reply-To: <200402161512.12171.m.watts@eris.qinetiq.com>
Message-ID: <Pine.LNX.4.58.0402160924150.15314@ryanr.aptchi.homelinux.org>
References: <Pine.LNX.4.58.0402150903010.1774@ryanr.aptchi.homelinux.org>
 <200402161512.12171.m.watts@eris.qinetiq.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Feb 2004, Mark Watts wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> > This is really trivial and I solved it anyway, but in all incarnations of
> > 2.6 I have had static coming from my speakers shortly after boot.  It only
> > lasts a few seconds and sounds as though someone were jiggling the plug in
> > the sound card's socket.  It only happens right after boot.  Since I
> > enabled Local APIC and IO-APIC it hasn't happened.
>
> Did you get a similar noise when shutting down?
>
> My other half has an AMD motherboard with onboard Via sound which gives a
> burst of static when KDE 3.1 starts and another when it shuts down. All other
> sound is fine. (Kernel 2.4.22)
>
> APIC's are disabled on this board...

No, just when starting up.  It doesn't even need to be in KDE; in fact, I've
never noticed it in KDE since I start in text mode and check my mail before
starting X (you know how it's impossible to hold off checking mail).  Your
problem sounds different since it's in 2.4, also, and I never saw this in 2.4.

However, KDE and sound don't always agree, in my experience.  They can't even
get their own sounds right sometimes; when shutting it down their "shutdown"
tune is always cut off as the aRts server exits before it finishes playing the
sound.  This, of course, is not static.

-- 
Ryan Reich
ryanr@uchicago.edu
