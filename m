Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUAOJUQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 04:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUAOJUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 04:20:16 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:48846 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S266499AbUAOJUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 04:20:11 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH] 2.6.1: Update PCI Name database, fix gen-devlist.c for  long device names.
Date: Thu, 15 Jan 2004 10:17:21 +0100
User-Agent: KMail/1.5.4
References: <5.1.0.14.2.20040115140515.00af1318@mail.mgpenguin.net> <40061188.8060705@pobox.com>
In-Reply-To: <40061188.8060705@pobox.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200401151017.22996.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 15 January 2004 05:05, Jeff Garzik wrote:
> We don't need these strings in the kernel at all.  pci.ids is just a
> static lookup table that is best kept in userspace.

Where it is always out of date, according to my experience. People tend
to update their kernel more often than lspci, so on most machines I've
been on, I usally point lspci to the kernel copy of it.

sth. needs to be done in this area in the main distros (e.g. more
frequent updates of just this file as a package would be fine).


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQFABlqhU56oYWuOrkARAs9AAKDhW5bfSVSV6VqpF1e7aDxgy3ZuQwCeKAk6
Bqu9S7eWlqtwLlimEA2Y0mE=
=Rvll
-----END PGP SIGNATURE-----

