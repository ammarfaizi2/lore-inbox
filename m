Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261466AbULFDxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261466AbULFDxL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 22:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbULFDxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 22:53:10 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:2264 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261466AbULFDxF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 22:53:05 -0500
Date: Mon, 6 Dec 2004 03:51:50 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Len Brown <len.brown@intel.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [BKPATCH] ACPI for 2.6.10
In-Reply-To: <1102304175.2312.25.camel@d845pe>
Message-ID: <Pine.LNX.4.61.0412060349300.24910@student.dei.uc.pt>
References: <1101945436.8026.392.camel@d845pe>  <Pine.LNX.4.61.0412031840340.19044@student.dei.uc.pt>
 <1102304175.2312.25.camel@d845pe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 5 Dec 2004, Len Brown wrote:

>> If this release is equivalent with -mm's bk-acpi.patch from
>> 2.6.10-rc2-mm1 to 2.6.10-rc2-mm4,
>> notice that this kernels' bk-acpi patches have the bug
>> described in http://lkml.org/lkml/2004/11/16/263 , so I wouldn't
>> really like to
>> see this pull done to 2.6.10 until the problem is solved...
>>
>> If you want, I can try this patch to see if it acts like
>> bk-acpi.patch, but I guess it does...
>
> Please try 2.6.10-rc3, which includes this set of patches.
>
> Yes, this set of patches includes most of what was in -mm, but not
> everything.  Note also, that it includes some more recent patches,
> including a poweroff fix, that was not in the -mm patches above.

2.6.10-rc3 works fine, so I guess that the poweroff fix solves the problem, or
the problem is in the stuff in -mm that isn't here...

I guess we'll have to wait for 2.6.10-rc3-mm1 to find out! ;-)

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

iD8DBQFBs9dXmNlq8m+oD34RAnuIAKC+9Uhr/Ry+/Is+oW5MJ5/v1HgSlQCfe4TB
cy/YxAM7tw91R+l+voQ9VVk=
=2y4d
-----END PGP SIGNATURE-----

