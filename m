Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751017AbWBOIhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751017AbWBOIhH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 03:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWBOIhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 03:37:07 -0500
Received: from mail.gmx.net ([213.165.64.21]:53704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751017AbWBOIhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 03:37:05 -0500
X-Authenticated: #428038
Date: Wed, 15 Feb 2006 09:37:01 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Rob Landley <rob@landley.net>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060215083701.GB32149@merlin.emma.line.org>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <5a2cf1f60602130407j79805b8al55fe999426d90b97@mail.gmail.com> <200602141751.02153.rob@landley.net> <20060215000420.GB21088@merlin.emma.line.org> <200602142155.03407.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200602142155.03407.rob@landley.net>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Rob Landley wrote:

> The last gasp of the SCSI bigots is Serial Attached Scsi.  It's hilarious.  
> Electrically it's identical (they just gold-plate the connectors and such so 
> they can charge more for it).

Gold plating contacts is nothing fancy that would have relevance for the
price elsewhere - but it is a way against corrosion, and been used for
decades with success. And contact problems make for nearly one half of
the issues I have here with older computers. In newer computers, having
components with moving parts that are too cheap (IOW they were saving
pennies from the wrong end) is a problem because it causes downtime
again.

> > You'd have to enable strace to actually unravel SG_IO contents, else
> > you're only getting a useless pointer - unless you trust cdrecord -V.
> 
> *shrug*  Or stick printfs in the source code.  Coasters are cheap and cd 
> rewriteables last a while if you don't scratch them up...

I'm not exactly a friend of empiric programming if I can help it.
Sometimes, when working with closed-source firmware, there's no other
choice, but that doesn't imply everything needs to be done that way.

>         All other make programs are either not smart enough or have bugs.

The bug in GNU make that Jörg complains so loudly is about is purely
cosmetic with no adverse effect on the stability of the build. It's just
spewing a few messages about non-existant .d files it is trying to
include, because of the way it works. The dependency on these files is
fully functional, it spews the warning, generates the file, and that's
it. If you feel uncomfortable with that, filter them.

GNU make is rock solid in projects much larger than Jörg can imagine,
and with more complex dependencies than he might oversee.

>         ***** If you are on a platform that is not yet known by the      *****
>         ***** Schily makefilesystem you cannot use GNU make.             *****
>         ***** In this case, the automake features of smake are required. *****
> 
> And yes, that _is_ entirely typical...

Reusing existing terms in different context is one of his hobbies, yes.

-- 
Matthias Andree
