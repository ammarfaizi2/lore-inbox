Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVASXXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVASXXl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVASXXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:23:41 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:37826 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261972AbVASXWm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:22:42 -0500
Date: Wed, 19 Jan 2005 23:06:10 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: "Barry K. Nathan" <barryn@pobox.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
In-Reply-To: <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net>
Message-ID: <Pine.LNX.4.61.0501192301370.8199@student.dei.uc.pt>
References: <20050114002352.5a038710.akpm@osdl.org>
 <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 14 Jan 2005, Barry K. Nathan wrote:

> This isn't new to 2.6.11-rc1-mm1, but it has the infamous (to Fedora
> users) "ACPI shutdown bug" -- poweroff hangs instead of actually turning
> the computer off, on some computers. Here's the RH Bugzilla report where
> most of the discussion took place:
>
> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132761

This is the same bug I've talked here:
http://lkml.org/lkml/2005/1/11/88

This only happens with -mm and not with vanilla sources.

I'm reporting about this issue in an ASUS M3N laptop with Debian.

Best regards,
Mind Booster Noori

> In the Fedora kernels it turned out to be due to kexec. I'll see if I
> can narrow it down further.
>
> -Barry K. Nathan <barryn@pobox.com>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

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

iD8DBQFB7ufzmNlq8m+oD34RAmsIAKDM55tzy957YqEXtNkz9l2O3O7V1ACeKXQB
v2LuSPMWch9A7NQApq6Bm8c=
=F7on
-----END PGP SIGNATURE-----

