Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWA3L1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWA3L1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWA3L1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:27:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:16788 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932220AbWA3L1j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:27:39 -0500
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chase Venters <chase.venters@clientec.com>,
       "linux-os \\(Dick Johnson\\)" <linux-os@analogic.com>,
       Kyle Moffett <mrmacman_g4@mac.com>, Marc Perkel <marc@perkel.com>,
       "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Patrick McLean <pmclean@cs.ubishops.ca>,
       Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
References: <43D114A8.4030900@wolfmountaingroup.com>
	 <20060120111103.2ee5b531@dxpl.pdx.osdl.net>
	 <43D13B2A.6020504@cs.ubishops.ca> <43D7C780.6080000@perkel.com>
	 <43D7B20D.7040203@wolfmountaingroup.com>
	 <43D7B5C4.5040601@wolfmountaingroup.com> <43D7D05D.7030101@perkel.com>
	 <D665B796-ACC2-4EA1-81E3-CB5A092861E3@mac.com>
	 <Pine.LNX.4.61.0601251537360.4677@chaos.analogic.com>
	 <Pine.LNX.4.64.0601251512480.8861@turbotaz.ourhouse>
	 <Pine.LNX.4.64.0601251728530.2644@evo.osdl.org>
	 <1138387136.26811.8.camel@localhost>
	 <Pine.LNX.4.64.0601272101510.3192@evo.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 30 Jan 2006 11:26:30 +0000
Message-Id: <1138620390.31089.43.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-01-27 at 21:06 -0500, Linus Torvalds wrote:
> > Not correct. See section 9.
> 
> Sorry, I think you're wrong.
> 
> We've _always_ said which license explicitly. It's in the COPYING file.
> 
> Even before the clarification, the COPYING file has always said 
> 
> 
>                     GNU GENERAL PUBLIC LICENSE
>                        Version 2, June 1991


--
If the Program specifies a version number of this License which applies
to it and "any later version", you have the option of following the
terms and conditions either of that version or of any later version
published by the Free Software Foundation.  If the Program does not
specify a version number of this License, you may choose any version
ever published by the Free Software Foundation.
--

"COPYING" is the license not the program. If it were the program you
would be violating the GPL as the GPL license text is not itself GPL
compatible. It is also not a statement of the version of the software
but a statement of the version of the document itself. Both seem quite
self evident and clear. Since the document itself provides choices for
versions to be applied it cannot be said to imply a version either.

Nowdays you specifically state version 2 then reproduce the license
document. That likewise seems self evident and clear. Section 9 probably
gives you the right to do that for any code that did not specify a
version rule already.

You might also want to ask "if the FSF COPYING text specified the
program version as you claim then how would you specify versions
differently". And likewise "How come the FSF itself, author of the
license, distributes its default COPYING file with code clearly intended
and marked to be GPL v2 or later".

In short your interpretation of the past state of affairs would not
stand up to scrutiny.

> If you distribute a program, and you just say "I license this under the 
> GPL", THEN you don't specify a verion.

And merely adding the copying file likewise is still not specifying a
version. You may be *implying* one but that is not specifying.

> Linux kernel files don't say "This is licensed under the GPL". Not mine, 
> at least. I don't see the point, and I never have. There's a COPYING file 

The point is to avoid ambiguity. Consider the statement in clause 2

--
In addition, mere aggregation of another work not based on the Program
with the Program (or with a work based on the Program) on a volume of
a storage or distribution medium does not bring the other work under
the scope of this License.
--

The COPYING file is mere aggregation - it is a seperately licensed and
independant work to the program with incompatible conditions. In the
kernel case this does not matter as you included text with COPYING to
make the intent clear, and there is no doubt, nor alternate licenses.

Consider however taking BSD 2 clause licensed code and relicensing it
GPL with changes. If the GPL was merely placed with the code it would
not be clear that the GPL now applied to it, especially if there are
other independant GPL programs in the same archive. The advice text with
the GPL itself thus provides for the 'fail safe' worst case scenario
rather than neccessarily addressing all cases in the minimal and neatest
fashion. Lawyers dislike amibguity because it causes expensive problems
later on.

(Also historically an assertion of copyright was neccessary avoid being
public domain in the USA and some other countries.)

Alan

