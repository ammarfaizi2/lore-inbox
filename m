Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbUKPXPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUKPXPB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbUKPXMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:12:06 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:52184 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S261892AbUKPXLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:11:07 -0500
Date: Tue, 16 Nov 2004 23:10:03 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: linux-kernel@vger.kernel.org
Subject: acpi_power_off issue in 2.6.10-rc2-mm1
Message-ID: <Pine.LNX.4.61.0411162301460.5829@student.dei.uc.pt>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-UC-FCTUC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-FCTUC-DEI-MailScanner: Found to be clean
X-MailScanner-From: marado@student.dei.uc.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Greetings,

In 2.6.10-rc2 and previous kernels acpi_power_off allways worked fine, but in
2.6.10-rc2-mm1 when I do 'halt' all runs fine, the last message "acpi_power_off
called. System is going to power off" (something like this, I don't recall
^-^;) appears, but then the machine just doesn't power off.

This is happening with an ASUS M3N laptop, I guess that it's a problem
somewhere in
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm1/broken-out/bk-acpi.patch
When I get some time I'll take a deeper look into it...

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

iD8DBQFBmojQmNlq8m+oD34RAhd7AKDo6w8CVnReUcGFsQu9ZvIH6lEiJACgm53v
uc8dsN/1UtPNhx3wyawub3Y=
=/Nbn
-----END PGP SIGNATURE-----

