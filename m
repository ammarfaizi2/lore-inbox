Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263576AbUECCve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUECCve (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263567AbUECCvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:51:32 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:37106 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S263578AbUECCvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:51:15 -0400
Date: Sun, 2 May 2004 19:51:09 -0700
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Numdimmies MUST DIE!
Message-Id: <20040502195109.3897ee2e@laptop.delusion.de>
In-Reply-To: <1083551201.25582.149.camel@bach>
References: <1083551201.25582.149.camel@bach>
Organization: Fiasco Core Team
X-GPG-Key: 1024D/233B9D29 (wwwkeys.pgp.net)
X-GPG-Fingerprint: CE1F 5FDD 3C01 BE51 2106 292E 9E14 735D 233B 9D29
X-Mailer: X-Mailer 5.0 Gold
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sun__2_May_2004_19_51_09_-0700_tJ+HAWAf/K9v4VUi"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Sun__2_May_2004_19_51_09_-0700_tJ+HAWAf/K9v4VUi
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 03 May 2004 12:26:42 +1000 Rusty Russell (RR) wrote:

RR> Status: Vitally Important
RR> 
RR> I'm sure this is violating the trademark of a pre-schooler's TV show
RR> somewhere in the world.

While you're at it, there's more (revised patch below):

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c
--- .18765-linux-2.6.6-rc3-bk4/drivers/net/dummy.c	2004-04-29 17:29:43.000000000 +1000
+++ .18765-linux-2.6.6-rc3-bk4.updated/drivers/net/dummy.c	2004-05-03 12:25:11.000000000 +1000
@@ -104,7 +104,7 @@ static struct net_device **dummies;
 
 /* Number of dummy devices to be set up by this module. */
 module_param(numdummies, int, 0);
-MODULE_PARM_DESC(numdimmies, "Number of dummy psuedo devices");
+MODULE_PARM_DESC(numdummies, "Number of dummy pseudo devices");
 
 static int __init dummy_init_one(int index)
 {

-Udo.

--Signature=_Sun__2_May_2004_19_51_09_-0700_tJ+HAWAf/K9v4VUi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlbOdnhRzXSM7nSkRAtW9AJ0cv/yF01tM3eRd6tQZyI4K9eAMigCeP4qt
5SmrSXDra8FrcKEw0Me8ebY=
=PYhA
-----END PGP SIGNATURE-----

--Signature=_Sun__2_May_2004_19_51_09_-0700_tJ+HAWAf/K9v4VUi--
