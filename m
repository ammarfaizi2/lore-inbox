Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422976AbWBAWOE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbWBAWOE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 17:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422979AbWBAWOE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 17:14:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11489 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422976AbWBAWOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 17:14:03 -0500
Date: Wed, 1 Feb 2006 14:13:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43E0C5E7.6050406@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0602011334270.21884@g5.osdl.org>
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
 <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org> <43E0C5E7.6050406@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Feb 2006, Rene Herman wrote:
> > 
> > but the fact is, the GPL also says that any license notices must be
> > kept intact, and that a copy of the GPL itself must be given along
> > with the program (in section 1).
> 
> The GPL text itself really is not under a GPL compatible license. The GPL says
> that, under certain provisions, "You may modify your copy or copies of the
> Program or any portion of it" (section 2) while the GPL document does not
> allow any modification, under any provision: "but changing it is not allowed".

You continue to ignore the big important fact that:

 - section 2 is _conditional_ on section 1
 - section 1 (and FSF guidelines) _requires_ you to leave copyright 
   notices intact and give the license out along with the program.

IOW, your claim that the GPL requires you to be able to make changes is 
INCORRECT.

The GPL requires you to be able to make a certain _class_ of changes, but 
other changes (like modifying the copyright license of notices or removing 
the license) are expressly _forbidden_ both by the GPL and by copyright 
law.

Think about it. The GPL is _not_ incompatible with including the GNU 
General Public License as part of the program. 

This can, btw, also be shown independently by the fact that the FSF 
clearly _intended_ the license to be actively linked into the program: 
they ask you (in the "How to Apply These Terms to Your New Programs") to 
have commands to view parts of the license if your program is interactive.

In other words, your claim that the license file itself is somehow 
"incompatible" with being included as part of the the GPL'd Program is 
simply not possible.

Btw, try this:

	shell$ gdb

	(gdb) show copying

and if you strace it (or do "strings" on the binary), you'll even notice 
that the license is very much part of the binary image itself. How much 
more "part of the program" can it be?

So if you seriously suggest that the GNU General Public License file is 
incompatible with the GPL, then that ignores the fact that

 - the license file itself assks you to combine it with the program
   (much more tightly than "mere aggregation")

 - the GPL license itself has the requirement that copyright licenses be 
   left intact (actually, the license itself seems to say just keep intact 
   all notices that "refer to this License", but the FSF has made it clear 
   that it covers _any_ copyright license notes, and that the GPL is 
   compatible with the BSD license which requires the same retention of 
   copyright notices).

or alternatively:

 - the FSF actively _encourages_ people to violate their own copyright 
   (which means that they can't sue, under the doctine of estoppel), and 
   your point is moot _anyway_.

So. Claiming that the GPL license text itself cannot be part of the 
program is disingenious. According to your reading, the modified BSD 
license wouldn't be compatible with the GPL either, because it requires:

 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions, and the following disclaimer,
 *    without modification.

yet the FSF has clearly stated that this is perfectly fine, even though it 
also disallows modifications to the license text.

Quod erat demonstrandum.

			Linus
