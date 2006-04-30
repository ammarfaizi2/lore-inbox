Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751101AbWD3Me3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbWD3Me3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 08:34:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751102AbWD3Me3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 08:34:29 -0400
Received: from mx27.mail.ru ([194.67.23.63]:46862 "EHLO mx27.mail.ru")
	by vger.kernel.org with ESMTP id S1751101AbWD3Me3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 08:34:29 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Checking modalias supported by vmlinux
Date: Sun, 30 Apr 2006 16:34:23 +0400
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604301634.26406.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is it currently (2.6.16.x) possible to get list of modaliases supported by 
bultin drivers as opposed to modules? The feature is "nice to have" for 
autodetecting mkinitrd. I.e. currently it is mostly possible to walk up 
starting from root device, collect modaliases and resolve them to modules. 
But if modalias is not resolved there is no obvious way to check, if driver 
is builtin. Of course, it is always possible to take optimistic approach and 
assume driver is just available ...

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEVK7SR6LMutpd94wRAqM2AJ9qUO8f5omaCr3yYOz5/4631ePiRgCfT3/H
3Ec8nVJT1U3ZaKI5LVzl6/k=
=zlrx
-----END PGP SIGNATURE-----
