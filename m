Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbULMQWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbULMQWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 11:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbULMQS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 11:18:57 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:2499 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261267AbULMQQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 11:16:08 -0500
Date: Mon, 13 Dec 2004 16:15:17 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc3-mm1
In-Reply-To: <20041213020319.661b1ad9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0412131603370.14874@student.dei.uc.pt>
References: <20041213020319.661b1ad9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 13 Dec 2004, Andrew Morton wrote:

>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/
>
> - Lots of new patches, lots of little fixes all over the place.
>
> - Probably the major change is the readahead rework, which may have
>  significant performance impacts on some workloads.  Not necessarily good,
>  either...
>
> - See below for the list of 31 patches which I have pending for 2.6.10.  If
>  there are other patches here which should go in, please let me know.

Greetings,

Fortunately with this -rc3-mm1 I no longer have the acpi_power_off problem that
I had in -rc2-mm's, described in http://lkml.org/lkml/2004/12/12/110 .

OTOH, while I had no problems with the previous mm's or with 2.6.10-rc3, with
- -rc3-mm1 kdm has an weird function: with kdm/unstable uptodate 4:3.3.1-3 from
Debian it just restarts X when it's going to show the login/password form,
restarting over and over.

If further info is needed on this issue just ask: meanwhile I'll try to find
which patch in -mm is doing this...

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

iD8DBQFBvcAXmNlq8m+oD34RAjb+AJsGLkWkTpMorcLL5yLjYjy+7YnktQCcCU7f
rEHsMhpp956Z3yzsfeUA0l8=
=kOEO
-----END PGP SIGNATURE-----

