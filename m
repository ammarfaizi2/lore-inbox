Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWBAO1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWBAO1i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 09:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWBAO1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 09:27:38 -0500
Received: from smtpq2.tilbu1.nb.home.nl ([213.51.146.201]:39613 "EHLO
	smtpq2.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932413AbWBAO1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 09:27:37 -0500
Message-ID: <43E0C5E7.6050406@keyaccess.nl>
Date: Wed, 01 Feb 2006 15:29:59 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com>  <20060120111103.2ee5b531@dxpl.pdx.osdl.net>  <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com>  <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>  <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>  <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>  <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>  <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain> <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com> <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com> <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <43DFDEF9.2030001@keyaccess.nl> <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> _Most_ of the kernel isn't copyrighted by "the same people". Many 
> parts of the kernel are available from tons of different people (and 
> are sometimes available under different licenses). That doesn't make 
> them less part of the kernel program.

Granted, I could have probably done without the "copyrighted by the same 
people" argument. What I attempted to emphasize is that the license text 
itself is an independent work, licensed under a different license than 
the program.

> And btw, the GPL (the license text) is not incompatible with itself.
> Yes, the license says
> 
> "Everyone is permitted to copy and distribute verbatim copies of this
> license document, but changing it is not allowed."
> 
> but the fact is, the GPL also says that any license notices must be
> kept intact, and that a copy of the GPL itself must be given along
> with the program (in section 1).

The GPL text itself really is not under a GPL compatible license. The 
GPL says that, under certain provisions, "You may modify your copy or 
copies of the Program or any portion of it" (section 2) while the GPL 
document does not allow any modification, under any provision: "but 
changing it is not allowed".

The bits above (also note how you said "along _with_ the program" and 
how the GPL itself says "applies _to_ the program) only further enhance 
the point with which I by now fully agree that the GPL text itself is 
not part of the program. As such, something other than the GPL text will 
have to specify a version to have the _program_ specify a version per 
section 9.

Your addition to the COPYING file certainly does just that, meaning any 
possible problem has been long solved.

> The requirement that you be able to modify and distribute the
> modified (section 2) is only _provided_ you also honor section 1. So
> the fact that you're not allowed to change the license text is _not_
> against the GPL itself, and including the license as part of the
> program is in no way against the GPL.

To be GPL compatible, you need to be compatible with all requirements of 
  the GPL, one of which is section 2. The licence the GPL text is under 
is not compatible with this section.

No, it's not against the program's license (the program being Linux and 
the license the GPL v2) to include the license with the program. There 
would only be a potential problem if the GPL text were to be considered 
_part of_ the program since then combining the GPL licensed program and 
the license text would require the license text to be under a GPL 
compatible license. As it is, it is included as a mere aggregation, and 
this is certainly fine.

Hope I'm not annoying you -- these are obviously points normally only a 
lawyer would enjoy arguing. If I am, maybe pointing out the thoroughly 
amusing recursion of having to distribute the GPL alongside the GPL if 
the GPL text itself would be licensed under the GPL itself (not even 
just a compatible license) makes it better? (<-- joke...).

> I'm convinced _that_ is how you get "no version specified" in section
> 9. You have a program that just says "This is licensed under the
> GPL", instead of doing the full thing.
> 
> And I say that the Linux kernel has contained a notice placed by the 
> copyright holder (the "COPYING" file) that says that it's to be 
> distributed under (and I quote from the top):
> 
> GNU GENERAL PUBLIC LICENSE Version 2, June 1991
> 
> and that's it.

I just saw Paul Jakma make a very strong point here. Section 9 would be 
useless if having the version in the header, of the same document, would 
be all that is required to have the program specify a version.

Having said all that... everybody agrees that the bit you added to the 
COPYING file is enough to have the kernel under the GPL v2 only. So, 
there's no need for this, but do you think it could be a good idea to 
add a file LICENSE, copyrighted by you, to the kernel that says that the 
kernel is licensed under the GPL v2, as supplied in the file COPYING 
(and moving the syscall bit as well, and restore COPYING to pristine)?

No, this would not change anything other than provide for an even _more_ 
unambiguous situation. In that case, noone would have to argue whether 
or not anything added to the COPYING file was part of the program 
proper. On the other hand, if doing so would make some people believe 
that anything changed, it could be counter-productive as well.

Wanted to suggest it though...

Rene.

