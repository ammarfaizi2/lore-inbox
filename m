Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751879AbWAOJ1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbWAOJ1A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 04:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbWAOJ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 04:27:00 -0500
Received: from mx3.mail.ru ([194.67.23.149]:26917 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751879AbWAOJ1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 04:27:00 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-xfs@oss.sgi.com
Subject: 2.6: xfs is rebuilt on every .config change
Date: Sun, 15 Jan 2006 12:26:46 +0300
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601151226.49461.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This happened for a long time, actually in late 2.5.x (that I have started 
with). Every time I make some changes to config - or simply do make oldconfig 
- - xfs is rebuilt. This happens when there are *no* changes related to xfs 
alltogether. E.g. I now applied 2.6.15.1 patch and xfs got rebuilt again.

It may be nitpicking, but it is huge module, I have relatively slow system ans 
sometimes want to quickly test some trvial changes. xfs doubles compile time 
(at the very least).

Regards

- -andrey 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDyhVZR6LMutpd94wRAufSAJkBc/y6KK5wkcyxVliZkuTYpdcn5QCgmovu
xRdPIPFuQNbI+u3Bv+AI1hA=
=cI9T
-----END PGP SIGNATURE-----
