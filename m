Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423040AbWBBAB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423040AbWBBAB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423045AbWBBAB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 19:01:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51604 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423040AbWBBAB5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 19:01:57 -0500
Date: Wed, 1 Feb 2006 16:01:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-Reply-To: <43E14451.1010100@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0602011540070.21884@g5.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com>  <43D13B2A.6020504@cs.ubishops.ca>
 <43D7D05D.7030101@perkel.com>  <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
  <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com> 
 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse> 
 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>  <1138387136.26811.8.camel@localhost>
  <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org> <1138620390.31089.43.camel@localhost.localdomain>
 <Pine.LNX.4.64.0601310931540.7301@g5.osdl.org> <43DF9D42.7050802@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311032180.7301@g5.osdl.org> <43DFB0F2.4030901@wolfmountaingroup.com>
 <Pine.LNX.4.64.0601311152070.7301@g5.osdl.org> <43DFDEF9.2030001@keyaccess.nl>
 <Pine.LNX.4.64.0601311430130.7301@g5.osdl.org> <43E0C5E7.6050406@keyaccess.nl>
 <Pine.LNX.4.64.0602011334270.21884@g5.osdl.org> <43E14451.1010100@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Feb 2006, Rene Herman wrote:
> > So. Claiming that the GPL license text itself cannot be part of the program
> > is disingenious. According to your reading, the modified BSD license
> > wouldn't be compatible with the GPL either, because it requires:
> > 
> >  * 1. Redistributions of source code must retain the above copyright
> >  *    notice, this list of conditions, and the following disclaimer,
> >  *    without modification.
> > 
> > yet the FSF has clearly stated that this is perfectly fine, even though it
> > also disallows modifications to the license text.
> 
> But please note that this is indeed perfectly fine, and does not contradict
> anything I say. This requirement only disallows modifications  to the copright
> and license notices, not modifications of the _program_ and the GPL is
> perfectly fine with that.

You continue to make this totally arbitrary distinction between "copyright 
and license notices" and the "program".

That distinction does not make any sense.

The "license notices" _are_ an integral part of the program. Nothing else 
makes sense. They are often in the same files (that's the most common case 
by far), and as I showed you, they are often (as in the case of the GPL 
license notice itself) actually _linked_in_ into the actual binary itself.

I find absolutely zero legal ground for your distinction that they are 
somehow a totally independent entity from "the program", and it is in 
fact in total disagreement with GPLv2 section 9 where they talk about the 
"Program" specifying a license version.

You seem to be saying that no copyright license or notice is ever part of 
the "Program", but that's totally idiotic. It would mean that you can 
_never_ specify a "license version" in the Program, because by your 
totally inconsistent rules, that copyright license note would 
automatically somehow magically not be part of "Program".

So your reading simply DOES NOT MAKE SENSE.

I claim that Copyright notices and licenses very much _are_ part of the 
program. I claim that because (a) the license says nothing to the contrary 
and (b) the license clearly _does_ talk of copyright notices within the 
Program (since the "Program" can specify a license version as per section 
9: how the hell could you specify a license version "in" the Program, if 
all copyright license notices were somehow magically "outside" the 
Program?)

You cannot have it both ways. You can't say that copyright license notes 
are sometimes outside the Program, and sometimes part of the Program.

The _only_ consistent reading is that copyright notices are _always_ part 
of the Program, and that you must leave them intact as per section 1. This 
also makes it clear that the "you must be able to modify" (section 2) does 
_not_ cover copyright notices and licenses, even though they _are_ part of 
the Program.

See? My reading is perfectly self-consistent, and doesn't need any 
artificial separation of "copyright notice" vs "Program". Yours is not. 

Your notion of copyright notes and licenses somehow being separate from 
"Program" simply cannot be reconciled with reality, common sense _or_ the 
wording in section 9.

The fact is, the copyright notices and licenses really _are_ a very 
integral part of "Program". You cannot separate one from the other - not 
conceptually, and not physically - and trying to do so would in fact be a 
clear violation of section 1.

			Linus
