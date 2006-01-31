Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWAaXJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWAaXJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 18:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWAaXJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 18:09:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:29367 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751055AbWAaXJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 18:09:16 -0500
Date: Tue, 31 Jan 2006 15:08:40 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43DFDEF9.2030001@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com> 
 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com> 
 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com> 
 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com> 
 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain>
 <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <43DFDEF9.2030001@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 31 Jan 2006, Rene Herman wrote:
> 
> And this is not a bad point -- the license and the program are indeed not the
> same; they are not even copyrighted by the same people.

Umm.. I really think that is a total strawman.

_Most_ of the kernel isn't copyrighted by "the same people". Many parts of 
the kernel are available from tons of different people (and are sometimes 
available under different licenses). That doesn't make them less part of 
the kernel program.

And btw, the GPL (the license text) is not incompatible with itself. Yes, 
the license says

 "Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed."

but the fact is, the GPL also says that any license notices must be kept 
intact, and that a copy of the GPL itself must be given along with the 
program (in section 1).

The requirement that you be able to modify and distribute the modified 
(section 2) is only _provided_ you also honor section 1. So the fact that 
you're not allowed to change the license text is _not_ against the GPL 
itself, and including the license as part of the program is in no way 
against the GPL.

So the fact that the license has a different copyright and is written by 
different people is in _no_ way different from the fact that other parts 
of the kernel were perhaps originally BSD-licensed. GPLv2 can happily 
cover those cases.

So go back instead to "section 0". Now THAT is I think the relevant one:

  "0. This License applies to any program or other work which contains
  a notice placed by the copyright holder saying it may be distributed
  under the terms of this General Public License. ..."

Notice how the GPLv2 text says that it applies to any program that just 
says it is licensed under the General Public License.

I'm convinced _that_ is how you get "no version specified" in section 9. 
You have a program that just says "This is licensed under the GPL", 
instead of doing the full thing.

And I say that the Linux kernel has contained a notice placed by the 
copyright holder (the "COPYING" file) that says that it's to be 
distributed under (and I quote from the top):

                    GNU GENERAL PUBLIC LICENSE
                       Version 2, June 1991

and that's it.

Ok. Back to work. This thread has been _waa-aayy_ too long.

			Linus
