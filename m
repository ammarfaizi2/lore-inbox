Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264509AbTL0R5k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 12:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTL0R5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 12:57:40 -0500
Received: from smtp.dei.uc.pt ([193.137.203.228]:7150 "EHLO smtp.dei.uc.pt")
	by vger.kernel.org with ESMTP id S264509AbTL0R5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 12:57:38 -0500
Date: Sat, 27 Dec 2003 17:56:28 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>, Andrew Morton <akpm@osdl.org>,
       GCS <gcs@lsc.hu>, linux-kernel@vger.kernel.org,
       Peter Osterlund <petero2@telia.com>
Subject: Re: Synaptics problems in -mm1
In-Reply-To: <20031227113848.GA10491@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.58.0312271755500.29577@student.dei.uc.pt>
References: <20031224095921.GA8147@lsc.hu> <200312250411.55881.dtor_core@ameritech.net>
 <200312250413.32822.dtor_core@ameritech.net> <200312250414.58598.dtor_core@ameritech.net>
 <20031227113848.GA10491@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


It kills the mouse tap on an Asus M3700N laptop too...

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

On Sat, 27 Dec 2003, Tomas Szepe wrote:

> Hi,
>
> it seems one of the synaptics-related patches in 2.6.0-mm1 kills
> off the pointer stick on my T40p.  2.6.0 vanilla works just fine
> in that department.  Thought you might want to know.
>
> Reverting
>
> 	input-08-synaptics-protocol-discovery.patch
> 	input-07-remove-synaptics-config-option.patch
> 	synaptics-powerpro-fix.patch
>
> did not seem to help.  I failed to figure out a way to easily revert
>
> 	serio-06-synaptics-use-reconnect.patch
> 	serio-04-synaptics-cleanup.patch
>
> so that I didn't try.
>
> --
> Tomas Szepe <szepe@pinerecords.com>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/7cfQmNlq8m+oD34RAqUVAKDiNxT4XZgyDxsB2AzTqrUnmWfqkgCfZLah
18UNuecee424OP85exMvWW4=
=hki0
-----END PGP SIGNATURE-----

