Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423021AbWBAX0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423021AbWBAX0w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 18:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423025AbWBAX0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 18:26:52 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:11736 "EHLO
	smtpq1.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S1423021AbWBAX0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 18:26:51 -0500
Message-ID: <43E14451.1010100@keyaccess.nl>
Date: Thu, 02 Feb 2006 00:29:21 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
References: <43D114A8.4030900@wolfmountaingroup.com>  <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>  <43D7B20D.7040203@wolfmountaingroup.com>  <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>  <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>  <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>  <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>  <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain> <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com> <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com> <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <43DFDEF9.2030001@keyaccess.nl> <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org> <43E0C5E7.6050406@keyaccess.nl> <Pine.LNX.4.64.0602011334270.21884@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602011334270.21884@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> You continue to ignore the big important fact that:
> 
>  - section 2 is _conditional_ on section 1

I'm not ignoring this -- I really just don't see it to be relevant. All 
sections have to be obeyed the same, and in this sense all sections are 
conditional on all others. Violate one, and the license is not available 
to you. This goes without saying.

>  - section 1 (and FSF guidelines) _requires_ you to leave copyright 
>    notices intact and give the license out along with the program.
> 
> IOW, your claim that the GPL requires you to be able to make changes is 
> INCORRECT.

There are two things here that need seperating. On the one hand, we have 
"the program". On the other we have "the license" (and license notices). 
The GPL requires you to be able to make changes to the program, not the 
license. In the context of the Linux kernel, Linux is the program, and 
the GPLv2 is the license. In the context of the GPLv2, the GPLv2 is the 
program, and:

  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.

is the license. If you couldn't change just this bit (and the FSF 
copyright) then things would not conflict. But this very license says 
you can't change _the program_ (the license document). This conflicts.

> This can, btw, also be shown independently by the fact that the FSF 
> clearly _intended_ the license to be actively linked into the
> program: they ask you (in the "How to Apply These Terms to Your New
> Programs") to have commands to view parts of the license if your
> program is interactive.

This, in fact, seems to be a good point. This one wants an FSF lawyer.

> So. Claiming that the GPL license text itself cannot be part of the 
> program is disingenious. According to your reading, the modified BSD 
> license wouldn't be compatible with the GPL either, because it requires:
> 
>  * 1. Redistributions of source code must retain the above copyright
>  *    notice, this list of conditions, and the following disclaimer,
>  *    without modification.
> 
> yet the FSF has clearly stated that this is perfectly fine, even though it 
> also disallows modifications to the license text.

But please note that this is indeed perfectly fine, and does not 
contradict anything I say. This requirement only disallows modifications 
  to the copright and license notices, not modifications of the 
_program_ and the GPL is perfectly fine with that.

This is the point I've tried to make a number of times now. The program 
is not the same thing as the license and allowing or disallowing 
something being done to the license is not the same thing as allowing or 
disallowing something to be done to the program. And in the case of the 
GPL license text, the license text _is_ the program. Not the license.

Note, we are arguing here over whether or not the GPL document itself is 
GPL compatible. I feel it obvious that it is not, you do not agree. What 
we _do_ agree on though is that it's wholy irrelevant for the kernel at 
least since 2.4.0-test8.

Ever since then, the kernel as a whole has been V2, not a doubt about 
it. You feel that even before that, it was V2 only but then you are 
ignoring the very strong point Paul Jakma made and which I repeated: if 
the "Version 2" in the GPL header were enough to have the program 
specify a version, section 9 would be utterly useless, and as such it's 
obvious that at very least the intent of the GPL authors here was that 
it was _not_ enough.

Hey, you still replied, so you probably don't think I'm completely full 
of it. Did you think there was any merit in the suggestion of seperating 
the GPL and the NOTE into separate files, so as to leave even fewer room 
for people trying to milk the argument?

Rene.

