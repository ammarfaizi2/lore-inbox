Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUJ0DSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUJ0DSI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 23:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbUJ0DSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 23:18:07 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:23440 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261611AbUJ0DR6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 23:17:58 -0400
Date: Wed, 27 Oct 2004 04:01:26 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linus Torvalds <torvalds@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <417EC260.1010401@tmr.com>
Message-ID: <Pine.LNX.4.61.0410270355160.20284@student.dei.uc.pt>
References: <417D7089.3070208@tmr.com><Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
 <Pine.LNX.4.58.0410251458080.427@ppc970.osdl.org> <417EC260.1010401@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 26 Oct 2004, Bill Davidsen wrote:

> Stop doing the pre's on the next version!

There are no -pre's in 2.6, at least not till now.

> After 2.6.10 comes 2.6.10.1 etc, 
> which everyone can see are incremental changes to 2.6.10, and when you really 
> mean it, then put out 2.6.11-rc1.

2.6.z.w is already "reserved" for another kind of updates. You're proposing a
system where you have:

2.6.10
2.6.10-???1
2.6.10-???2
2.6.10-???3
2.6.11-rc1
2.6.11-rc2
2.6.11-rc3
2.6.11
...

Or, in other words, you don't want Linus to "Stop doing the pre's", you're
wanting exactly the same scheme 2.4 is using and works preety fine: just
replace 10 by 11 in the '???' series, replace '???' by 'pre' and you have:

x.y.z
x.y.z+1-pre1
...
x.y.z+1-preN
x.y.z+1-rc1

2.4 model allways worked fine, we should stick with it instead of pulling our
hair out trying to figure out how to solve the problem that is already solved.

Mind Booster Noori

- -- 
/* *************************************************************** */
    Marcos Daniel Marado Torres	     AKA	Mind Booster Noori
    http://student.dei.uc.pt/~marado   -	  marado@student.dei.uc.pt
    () Join the ASCII ribbon campaign against html email, Microsoft
    /\ attachments and Software patents.   They endanger the World.
    Sign a petition against patents:  http://petition.eurolinux.org
/* *************************************************************** */
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFBfw+JmNlq8m+oD34RAmsdAJwOMJz7GqtQV3zG/DJYz14pioNADACfTI3H
fVfR9SmC8BxHpmT0B9rWVNk=
=avZN
-----END PGP SIGNATURE-----

