Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbTKJIrh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 03:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTKJIrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 03:47:36 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263053AbTKJIrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 03:47:35 -0500
Date: Mon, 10 Nov 2003 08:50:44 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311100850.hAA8oiIX000283@81-2-122-30.bradfords.org.uk>
To: Rob Landley <rob@landley.net>, Krzysztof Halasa <khc@pm.waw.pl>,
       <linux-kernel@vger.kernel.org>
In-Reply-To: <200311091754.21619.rob@landley.net> 
References: <m3u15de669.fsf@defiant.pm.waw.pl>
 <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk>
 <200311091754.21619.rob@landley.net>
Subject: Re: Some thoughts about stable kernel development
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Rob Landley <rob@landley.net>:
> On Sunday 09 November 2003 13:50, John Bradford wrote:
> > Hi Linus,
> >
> > [Off-list]
> >
> > Quote from Krzysztof Halasa <khc@pm.waw.pl>:
> > > Such a scenario is real and that way we might
> > > end up with official kernel being unusable for any Internet-connected
> > > tasks for weeks.
> >
> > This does highlight a real issue - I am concerned by the number of
> > posts on sites like lwn.net saying things like, "Oh, I'm using 2.6 as
> > my standard kernel now", when it is clear that a lot of those users
> > simply do not understand the issues.
> 
> At the same time, you _want_ as many testers as you can get finding the 
> strange bugs where burning cd's on an ACPI-powered laptop interacts strangely 
> with 3D acceleration.  And now that we're in the -test series, we want _more_ 
> of them.

Note - this was post incomplete and badly thought out - I never
intended this to go to the list, as evidenced by the [Off-list]
comment, and the only reason it was sent at all is because I hit send
instead of delete, (and hadn't trimmed the CC list yet).

What I originally intended to say in a private comment to Linus, is
that it might be worth trying to make people more aware that security
patches that went in to 2.4 never went in to 2.6, nothing more, and
nothing less.  I am NOT trying to put people off of testing, and never
have been, (which is the impression I got from your response).

> Security considerations are just one more element 
> of the party mix, and most of these are local (they've got to have broken 
> into the box ANYWAY, it just potentially lets 'em crack root once they're 
> in).
> 
> I'm still a lot more worried about what the kernel's doing to my filesystem 
> than what some malicious twit on the internet is likely to do.  That's the 
> main reason it's still -test...

No, I disagree.  If somebody's filesystem gets eaten, and they didn't
back up, well, they should have done.  That's common sense.

On the other hand, many users out there are _obviously_ under the
illusion that 2.6.0-test has no known security issues, and that is
false.  If their machine is internet-connected and compromised, it can
cause annoyance to third parties.  Given that, I think a file in the
root of the kernel tree, saying something like, "Don't use me on an
internet connected machine unless you know what you're doing" would be
worth considering.

John.
