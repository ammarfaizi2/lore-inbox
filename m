Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTKIX5v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 18:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbTKIX5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 18:57:51 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:43669
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S261226AbTKIX5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 18:57:49 -0500
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: John Bradford <john@grabjohn.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Some thoughts about stable kernel development
Date: Sun, 9 Nov 2003 17:54:21 -0600
User-Agent: KMail/1.5
References: <m3u15de669.fsf@defiant.pm.waw.pl> <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200311091950.hA9Jo01d002041@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311091754.21619.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 November 2003 13:50, John Bradford wrote:
> Hi Linus,
>
> [Off-list]
>
> Quote from Krzysztof Halasa <khc@pm.waw.pl>:
> > Such a scenario is real and that way we might
> > end up with official kernel being unusable for any Internet-connected
> > tasks for weeks.
>
> This does highlight a real issue - I am concerned by the number of
> posts on sites like lwn.net saying things like, "Oh, I'm using 2.6 as
> my standard kernel now", when it is clear that a lot of those users
> simply do not understand the issues.

At the same time, you _want_ as many testers as you can get finding the 
strange bugs where burning cd's on an ACPI-powered laptop interacts strangely 
with 3D acceleration.  And now that we're in the -test series, we want _more_ 
of them.

We know it's not safe.  There's a very real risk of a data-eating bug that 
could take out our filesystem (especially if we're using things like software 
suspend).  Of course those of us dragging laptops around have a very real 
risk of getting the suckers rained on, dropped, stolen, etc.  Very few 
non-laptop computers get run over by one's own car.  There's a larger than 
average chance of unintentional beverage interaction too, since the vital 
components are right under the keyboard in the beverage equivalent of ground 
zero.  (And don't tell me the hard drive enjoys being right under the 
keyboard, either.  Thump, thump, thump...)

So we have to back up a lot anyway. :)

99% of computer users don't understand the "issues" of connecting Windows XP 
to the internet, yet they do it anyway.  (Well, about 20% of them do.  More 
than that use W2k, and more than _that_ still use 98!)  I'd say there are a 
lot more issues with XP than 2.6.  (For one thing, 2.6 doesn't dial home to 
Linus and tell him what software packages you've installed. :)

I don't see what point is served by warning people away from a beta, pre-.0 
release.  I think we know.  Security considerations are just one more element 
of the party mix, and most of these are local (they've got to have broken 
into the box ANYWAY, it just potentially lets 'em crack root once they're 
in).

I'm still a lot more worried about what the kernel's doing to my filesystem 
than what some malicious twit on the internet is likely to do.  That's the 
main reason it's still -test...

Rob
