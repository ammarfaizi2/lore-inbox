Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262650AbUKQV7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262650AbUKQV7q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUKQVEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:04:05 -0500
Received: from mail.dif.dk ([193.138.115.101]:56748 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262543AbUKQVCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:02:05 -0500
Date: Wed, 17 Nov 2004 22:11:21 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       Fruhwirth Clemens <clemens@endorphin.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Morris <jmorris@redhat.com>
Subject: Re: GPL version, "at your option"?
In-Reply-To: <1100708189.512.64.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0411172200190.3438@dragon.hygekrogen.localhost>
References: <1100614115.16127.16.camel@ghanima> 
 <Pine.LNX.4.53.0411161547260.7946@gockel.physik3.uni-rostock.de> 
 <Pine.LNX.4.58.0411160746030.2222@ppc970.osdl.org> 
 <1100704183.32677.28.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0411170822200.2222@ppc970.osdl.org>
 <1100708189.512.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004, Alan Cox wrote:

> On Mer, 2004-11-17 at 16:28, Linus Torvalds wrote:
> > That said, when I clarified (and I do want to make clear that the header 
> > on the COPYING file is a _clarification_, not a change of license) it, I 
> > told people that if they disagreed with me, they should send in patches 
> > saying "v2 or later" to their own code.
> 
> Well no obligation exists, but please add "All code owned by Alan Cox
> and present in this kernel is licensed GPL v2 or later" to your copying
> or another appropriate file. (A comment in the code for each one would
> be rather messy)
> 
> It might be a good idea to figure out how to have a list of contributors
> who've said that or "v2 - or if Linus Torvalds so chooses, a later
> version"
> 

How about adding a new field to the entry for each person in the CREDITS
file?

Something like this perhaps :

--- linux-2.6.10-rc2-orig/CREDITS	2004-11-17 01:18:58.000000000 +0100
+++ linux-2.6.10-rc2/CREDITS	2004-11-17 22:04:00.000000000 +0100
@@ -2,8 +2,8 @@
 	contributed to the Linux project.  It is sorted by name and
 	formatted to allow easy grepping and beautification by
 	scripts.  The fields are: name (N), email (E), web-address
-	(W), PGP key ID and fingerprint (P), description (D), and
-	snail-mail address (S).
+	(W), PGP key ID and fingerprint (P), description (D), 
+	license notes (L), and snail-mail address (S).
 	Thanks,
 
 			Linus
@@ -1608,6 +1608,8 @@
 N: Jesper Juhl
 E: juhl-lkml@dif.dk
 D: Various small janitor fixes, cleanups etc.
+L: Contributed code is licensed under the GPL v2, or at your option any
+L: later version.
 S: Lemnosvej 1, 3.tv
 S: 2300 Copenhagen S
 S: Denmark


That doesn't account for everyone who has ever contributed code, but it 
does cover quite a few people if we can get anyone who's in there to add a 
similar line and encourage people who are not represented in CREDITS to 
submit an entry.
Of course there will still be some people it is impossible to reach (some 
dead, some just non-communicative) - some of those missing people may have 
left appropriate licensing info in source file comments, list emails or 
similar, so maybe that info could be used for their entry. For everyone 
else who either do not want to be listed in CREDITS or who are "missing" 
and have not left any clues as to their licensing preferences, well, I 
guess the COPYING file would then apply to them - or?


--
Jesper Juhl

