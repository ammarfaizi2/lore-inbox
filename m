Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264720AbTFAT4t (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 15:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264721AbTFAT4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 15:56:49 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:23563 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264720AbTFAT4s convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 15:56:48 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: warning: process 'update' used the obsolete bdflush...
Date: Sun, 1 Jun 2003 22:09:05 +0200
User-Agent: KMail/1.5.2
References: <1B8F41EC-934B-11D7-B416-00039346F142@mac.com> <1054495899.943.2.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1054495899.943.2.camel@teapot.felipe-alfaro.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306012209.05634.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 01 June 2003 21:31, Felipe Alfaro Solana wrote:
> "update" is not a program, but a kernel daemon that was superseded by
> pdflush in 2.5 kernels. I just can't remember right know what caused
> that warning, but it's similar to the SO_BSDCOMPAT warning that is
> triggered when running bind.

calling syscall bdflush() triggers this warning.
this syscall is obsolete.
Things can now be done through /proc/sys/vm

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 22:07:21 up  2:53,  3 users,  load average: 1.00, 1.07, 1.06

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+2l1hoxoigfggmSgRApnXAJkBfQw8CBVaUmJRuCNGA/8oZOAPygCfYREJ
sHauLAtZZfbcbAC+P9OL3BE=
=zBAB
-----END PGP SIGNATURE-----

