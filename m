Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbTILC5m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 22:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbTILC5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 22:57:42 -0400
Received: from smtp1.globo.com ([200.208.9.168]:7611 "EHLO mail.globo.com")
	by vger.kernel.org with ESMTP id S261498AbTILC5i convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 22:57:38 -0400
From: Marcelo Penna Guerra <eu@marcelopenna.org>
To: linux-kernel@vger.kernel.org
Subject: SII SATA request size limit
Date: Thu, 11 Sep 2003 23:57:06 -0300
User-Agent: KMail/1.5.9
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-Id: <200309112357.41592.eu@marcelopenna.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

In recent kernels, the siimage driver limits the max kb per request size to 15 
(7.5kb). As I was having no problems with rqsize of 128 (64kb), I decided to 
comment out this part of the code and my system is rock solid.

I'm not suggesting that it should be removed, as it probably is necessary on 
other systems, but as the performance impact is huge (with 15 hdparm tests 
show an average 26mb/s and with 128 it's 47mb/s), I think the user should be 
warnned of this and there could be a option to set it to 128 in 2.6.x 
kernels, so people can try to see if it's stable. I really don't beleive that 
I have such an unique hardware configuration, so this should benefit other 
people.

Marcelo Penna Guerra
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/YTYjD/U0kdg4PFoRAhBnAJ0TyeJx5nrxzDS5Rib5AEWQHx4iSACeKcn8
wg7cUhLobywfTCcPl8GqNCc=
=VuVw
-----END PGP SIGNATURE-----
