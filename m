Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTEDXme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 19:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261846AbTEDXme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 19:42:34 -0400
Received: from muss.CIS.mcmaster.ca ([130.113.64.9]:51953 "EHLO
	cgpsrv1.cis.mcmaster.ca") by vger.kernel.org with ESMTP
	id S261843AbTEDXmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 19:42:33 -0400
From: Gabriel Devenyi <devenyga@mcmaster.ca>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.68] KernelJanitor - Change applicable char *foo to char foo[]
Date: Mon, 5 May 2003 19:53:04 -0400
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305051953.16285.devenyga@mcmaster.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch applies to Linux 2.5.68. It converts appropriate string declarations(those which are only read) to the memory saving char foo[] version.

http://muss.mcmaster.ca/~devenyga/linux-2.5.68-char-changes.patch

Please CC me with any discussion.
- -- 
Building the Future,
Gabriel Devenyi
devenyga@mcmaster.ca
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+tvlk7I5UBdiZaF4RAnUyAJwNpcGmuWfzGjN9qVBjTF90XgKvjgCfX2pt
wcfQq8U4yIegqjoA+paMK6k=
=HF++
-----END PGP SIGNATURE-----

