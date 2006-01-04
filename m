Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964789AbWADWMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964789AbWADWMD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 17:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965274AbWADWMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 17:12:03 -0500
Received: from mail.linicks.net ([217.204.244.146]:21184 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S964789AbWADWL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 17:11:57 -0500
From: Nick Warne <nick@linicks.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 22:10:47 +0000
User-Agent: KMail/1.9
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org,
       webmaster@kernel.org
References: <200601041710.37648.nick@linicks.net> <200601042010.36208.s0348365@sms.ed.ac.uk> <20060104220157.GB12778@kroah.com>
In-Reply-To: <20060104220157.GB12778@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601042210.47152.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 22:01, Greg KH wrote:

> > > > Nick's right, both are provided automatically by kernel.org.
> > >
> > > Anyway, I started from scratch - 2.6.14, patched to 2.6.15 and then
> > > make oldconfig etc.
> > >
> > > I think there needs to be a way out of this that is easily discernible
> > > - it does get confusing sometimes with all the patches flying around on
> > > a 'stable release'.
> >
> > It's documented in the kernel.
> >
> > There's something in the kernel.org FAQ there about -rc kernels, but it
> > might be better to generalise this for stable releases. Added hpa to CC.
>
> What do you mean, "generalize" this?  Where else could we document it
> better?

The issue I hit was we have a 'latest stable kernel release 2.6.14.5' and 
under it a 'the latest stable kernel' (or words to that effect) on 
kernel.org.

Then when 2.6.15 came out, that was it!  No patch for the 'latest stable 
kernel release 2.6.14.5'.  It was GONE!

OK, I suppose we are all capable of getting back to where we are on rebuilding 
to latest 'stable', but there _is_ a missing link for somebody that doesn't 
know - and I think backtracking patches isn't really the way to go if the 
'latest stable release' isn't catered for.

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
