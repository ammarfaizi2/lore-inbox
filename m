Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUAFDPp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 22:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265342AbUAFDPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 22:15:45 -0500
Received: from smtp2.dei.uc.pt ([193.137.203.229]:59593 "EHLO smtp2.dei.uc.pt")
	by vger.kernel.org with ESMTP id S265339AbUAFDPX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 22:15:23 -0500
Date: Tue, 6 Jan 2004 03:14:45 +0000 (WET)
From: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [Bugfix] Set more than 32K pid_max (reformatted)
In-Reply-To: <Pine.LNX.4.44.0401061042580.26260-100000@mazda.sh.intel.com>
Message-ID: <Pine.LNX.4.58.0401060313470.14795@student.dei.uc.pt>
References: <Pine.LNX.4.44.0401061042580.26260-100000@mazda.sh.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-UC-DEI-MailScanner-Information: Please contact helpdesk@dei.uc.pt for more information
X-UC-DEI-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 6 Jan 2004, Zhu, Yi wrote:

>         if (!offset || !atomic_read(&map->nr_free)) {
> +               if (!offser)

I suppose it should be "if (!offset)"...

Mind Booster Noori

- --
==================================================
Marcos Daniel Marado Torres AKA Mind Booster Noori
/"\               http://student.dei.uc.pt/~marado
\ /                       marado@student.dei.uc.pt
 X   ASCII Ribbon Campaign
/ \  against HTML e-mail and Micro$oft attachments
==================================================

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQE/+igomNlq8m+oD34RAgGcAJ9p12OYiL/XKCJu4JPczbNO8+P6rwCg3Wdz
eIkeuX3q4JuVHaLeGXGIDIA=
=vP/K
-----END PGP SIGNATURE-----

