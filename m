Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262771AbVAKOYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262771AbVAKOYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 09:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbVAKOYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 09:24:35 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:41920 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S262771AbVAKOXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 09:23:03 -0500
Date: Tue, 11 Jan 2005 14:08:19 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: acpi_power_off on 2.6.10-mm3 WAS: Re: 2.6.10-mm2
In-Reply-To: <Pine.LNX.4.61.0501061203250.23199@student.dei.uc.pt>
Message-ID: <Pine.LNX.4.61.0501111407230.23838@student.dei.uc.pt>
References: <20050106002240.00ac4611.akpm@osdl.org>
 <Pine.LNX.4.61.0501061203250.23199@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCT-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCT-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thu, 6 Jan 2005, Marcos D. Marado Torres wrote:

> On Thu, 6 Jan 2005, Andrew Morton wrote:
>
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10/2.6.10-mm2/
>> 
>> - Various minorish updates and fixes
>
> The acpi_power_off issue (acpi_power_off is called but the laptop doesn't 
> shut
> down) is back (in -mm1 already). I suspect it has never disappear completely:
> maybe it only happens in some cenarios (like "only when AC is plugged in" or
> something like that). The report is done, I'll try to get more info soon 
> (when
> does this happen and when it doesn't) and will report it by then.

This still happens in -mm3.
I'll try to see which patch is breaking it...

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

iD8DBQFB493XmNlq8m+oD34RAjSXAJ0UeQfsEeBCje8GX9MJCJNw4RnUFwCg10yi
zFdcErqu1E3CVYgvFZa3Thg=
=stjp
-----END PGP SIGNATURE-----

