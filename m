Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266022AbUFVW1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266022AbUFVW1C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 18:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266040AbUFVWZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 18:25:27 -0400
Received: from pk128.szczecin.sdi.tpnet.pl ([217.98.202.128]:34320 "EHLO
	viper.elektronika.org") by vger.kernel.org with ESMTP
	id S266014AbUFVWXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 18:23:40 -0400
Date: Wed, 23 Jun 2004 00:25:18 +0200
From: =?ISO-8859-2?Q?Micha=B3?= Byrecki <byrek@elektronika.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Deadlock when mounting cdrom (kernel 2.4.26)
Message-Id: <20040623002518.47f96003@quake>
In-Reply-To: <20040622171256.GA15178@plant.adj.org>
References: <20040622171256.GA15178@plant.adj.org>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__23_Jun_2004_00_25_18_+0200_jKJ5o1ZZyqGi=ln2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__23_Jun_2004_00_25_18_+0200_jKJ5o1ZZyqGi=ln2
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 22 Jun 2004 19:12:56 +0200
Alain DIDIERJEAN <didierj@plant.adj.org> wrote:

> 1. The machine freezes when mounting a cdrom  
> 2. The command: mount cdrom           displays
>    hdb DMA interrupt recovery
>    hdb lost interrupt

I had an 'interrupt lost' error on 2.6.6. Passing"acpi=noirq" to
kernel solved the problem.

-- 
Regards,
Michal Byrecki

--Signature=_Wed__23_Jun_2004_00_25_18_+0200_jKJ5o1ZZyqGi=ln2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA2LHS5XTnZad2rEMRArxAAKCH0HSPrJceqONZ5KDWGKcLPtEBBACggFKU
GXPisRLv3sW8TqrN2OWT1rM=
=Tgbv
-----END PGP SIGNATURE-----

--Signature=_Wed__23_Jun_2004_00_25_18_+0200_jKJ5o1ZZyqGi=ln2--
