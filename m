Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262594AbUJ0UPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262594AbUJ0UPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 16:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262675AbUJ0UNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 16:13:48 -0400
Received: from smtp.dei.uc.pt ([193.137.203.228]:12164 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262432AbUJ0UGm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:06:42 -0400
Date: Wed, 27 Oct 2004 20:46:28 +0100 (WEST)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: John Richard Moser <nigelenki@comcast.net>
cc: "Theodore Ts'o" <tytso@mit.edu>,
       William Lee Irwin III <wli@holomorphy.com>,
       Willy Tarreau <willy@w.ods.org>, Rik van Riel <riel@redhat.com>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
In-Reply-To: <417FC02C.3090001@comcast.net>
Message-ID: <Pine.LNX.4.61.0410272043080.11962@student.dei.uc.pt>
References: <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt>
 <Pine.LNX.4.44.0410270027110.21548-100000@chimarrao.boston.redhat.com>
 <20041027051342.GK19761@alpha.home.local> <20041027052321.GT15367@holomorphy.com>
 <417FA711.90700@comcast.net> <20041027145743.GA16666@thunk.org>
 <417FC02C.3090001@comcast.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 27 Oct 2004, John Richard Moser wrote:

> What I *am* aiming for is getting a few security enhancements included
> in mainline for several Linux distributions, starting with Debian and
> Ubuntu.  This will predictibly create a blockage at 2.6.7 (where
> PaX/GRSec are, since those are a major part of the scheme); they won't
> be able to upgrade past there without losing a major protection, and the
> authors will likely continue to simply sit around and wait for 2.6 to
> stop changing so damn much.

Well, if your target is Debian and Ubunto for starts, then you're discussing
this in the wrong mailing list.
BTW, on Debian/unstable:

root@Atlantis:/usr/src/linux# apt-cache search kernel-image | grep 2.6.8
kernel-image-2.6.8-1-386 - Linux kernel image for version 2.6.8 on 386.
kernel-image-2.6.8-1-686 - Linux kernel image for version 2.6.8 on PPro/Celeron/PII/PIII/PIV.
kernel-image-2.6.8-1-686-smp - Linux kernel image for version 2.6.8 on PPro/Celeron/PII/PIII/PIV SMP.
kernel-image-2.6.8-1-k7 - Linux kernel image for version 2.6.8 on AMD K7.
kernel-image-2.6.8-1-k7-smp - Linux kernel image for version 2.6.8 on AMD K7 SMP.
kernel-image-2.6.8-9-amd64-generic - Linux kernel image for version 2.6.8 on generic x86_64 systems
kernel-image-2.6.8-9-amd64-k8 - Linux kernel image for version 2.6.8 on AMD64 systems
kernel-image-2.6.8-9-amd64-k8-smp - Linux kernel image for version 2.6.8 on AMD64 SMP systems
kernel-image-2.6.8-9-em64t-p4 - Linux kernel image for version 2.6.8 on Intel EM64T systems
kernel-image-2.6.8-9-em64t-p4-smp - Linux kernel image for version 2.6.8 on Intel EM64T SMP systems
kernel-tree-2.6.8 - Linux kernel tree for building prepackaged Debian kernel images
root@Atlantis:/usr/src/linux#

If you think the blockage is going to happen in 2.6.7, think twice.

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

iD8DBQFBf/sVmNlq8m+oD34RAlbAAKCSDhKthrmCDC55xa03ZOPvN8iRhwCgtEyD
l9vq0gBflZHARKQIQ+OSq/c=
=eXD0
-----END PGP SIGNATURE-----

