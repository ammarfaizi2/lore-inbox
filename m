Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbTFRPZH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265279AbTFRPZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:25:07 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:195 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S265278AbTFRPZE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:25:04 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Interactivity fix for 2.4.21-ck1
Date: Thu, 19 Jun 2003 01:38:56 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306190139.00264.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've posted a bugfix update for 2.4.21-ck1 that includes a fix for the long 
standing interactivity bug that I've been battling with. This patch reverts 
timeslices back to normal length as well. It makes a massive difference to 
system responsiveness under very heavy load, and eliminates audio skips in my 
testing. I highly recommend anyone using any -ck patchset up to 2.4.21-ck1 to 
update.

http://kernel.kolivas.org

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+8IeQF6dfvkL3i1gRAoEQAKCnduFxF/BGOZr0Qxw91VNi3XUVFACdHPxM
0ipG/nVjcXJG2/2v4QbK5GU=
=CCYI
-----END PGP SIGNATURE-----

