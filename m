Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759634AbWLCM0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759634AbWLCM0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759628AbWLCM0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:26:06 -0500
Received: from mx5.mail.ru ([194.67.23.25]:44387 "EHLO mx5.mail.ru")
	by vger.kernel.org with ESMTP id S1759633AbWLCM0E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:26:04 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-acpi@vger.kernel.org
Subject: 2.6.19: ACPI reports AC not present after resume from STD
Date: Sun, 3 Dec 2006 15:25:55 +0300
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612031526.00861.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I started to notice it some time ago; I can't say exactly if this was not 
present in earlier versions because recently I switched from STR (which gave 
me no end of troubles) to STD. So I may have not seen it before.

Suspend to disk while on battery. Plug in AC, resume. ACPI continues to show 
AC adapter as not present:

{pts/0}% cat /proc/acpi/ac_adapter/ADP1/state
state:                   off-line

replugging AC correctly changes state to on-line.

The system is Toshiba Portege 4000; I am not sure which information may be 
required in this case so please tell what is needed (unfortunately I will be 
off next two weeks without access to this system).

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcsJYR6LMutpd94wRAqSeAJ4n3lHqbdvgBeXxeIc9ZUTDe/X2jgCgyfU5
w+heEYYnA3Al/U9xHovOkQ4=
=F+Zu
-----END PGP SIGNATURE-----
