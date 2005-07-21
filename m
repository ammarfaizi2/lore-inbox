Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVGULw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVGULw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 07:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261762AbVGULw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 07:52:29 -0400
Received: from dns.kernelconcepts.de ([212.60.202.194]:21256 "EHLO
	gateway.kernelconcepts.de") by vger.kernel.org with ESMTP
	id S261760AbVGULw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 07:52:27 -0400
Message-ID: <42DF8C7B.6090905@kernelconcepts.de>
Date: Thu, 21 Jul 2005 13:52:27 +0200
From: Nils Faerber <nils.faerber@kernelconcepts.de>
Organization: kernel concepts
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: Nils Faerber <nils@kernelconcepts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove unneeded indentation in drivers/char/watchdog/i8xx_tco.c
References: <200507201036.20165@bilbo.math.uni-mannheim.de>
In-Reply-To: <200507201036.20165@bilbo.math.uni-mannheim.de>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rolf Eike Beer schrieb:
> Hi,
hi!

> this patch changes a bit of indentation. Currently it is
> if (i8xx_tcp_pci) {
> .....
> 	return 1;
> }
> return 0;
> 
> Now it will be
> 
> if (!i8xx_tcp_pci)
> 	return 0;
> .....
> return 1;
> 
> Also some superfluous spaces are killed to match Codingstyle

Don't know who added those strange things ;)
But looks OK to me to change it this way.

So please go ahead and forward this patch.

Many thanks!

  nils

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFC34x7JXeIURG1qHgRAs8HAKCHYD34TC3eDTGMQUnj4yrYM735bwCgkOAq
8kJdpgtczkWQd+MA+t7MxA0=
=JDJC
-----END PGP SIGNATURE-----
