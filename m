Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbUFEMM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUFEMM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 08:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUFEMM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 08:12:58 -0400
Received: from zeus.kernel.org ([204.152.189.113]:4004 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261184AbUFEMMy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 08:12:54 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] NFS no longer updates file modification times appropriately
Date: Fri, 4 Jun 2004 05:25:38 +0200
User-Agent: KMail/1.6.2
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, joe.korty@ccur.com
References: <20040603202846.GA28479@tsunami.ccur.com> <1086297112.3659.3.camel@lade.trondhjem.org>
In-Reply-To: <1086297112.3659.3.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406040525.40972.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi there,

On Thursday 03 June 2004 23:11, Trond Myklebust wrote:
> ...and no - we do not update timestamps on the client side when we cache
> the write, 'cos NFS does not provide any device for ensuring that clocks
> on client and server are synchronized.

Could you make this an option? The device ensuring this is the an admin
with a clue, who configures NTP or similiar in his network.

If unsure you could at least disable it by default.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAv+uyU56oYWuOrkARAvbCAJ0cG2HI4ScMAR8R8Iie5NN1FerGoQCdExHm
RF4Y/hZoKf4DuTr1w9lLPKY=
=EmI4
-----END PGP SIGNATURE-----
