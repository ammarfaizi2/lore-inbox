Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUHISJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUHISJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUHISJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:09:50 -0400
Received: from server02.akkaya.de ([213.168.83.203]:23645 "EHLO
	server02.akkaya.de") by vger.kernel.org with ESMTP id S266813AbUHISJn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:09:43 -0400
From: Juergen Pabel <jpabel@akkaya.de>
Organization: Akkaya Consulting GmbH
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
Date: Mon, 9 Aug 2004 20:12:47 -0400
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408080413.29905.jpabel@akkaya.de> <20040808134432.678629d0.akpm@osdl.org>
In-Reply-To: <20040808134432.678629d0.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408092012.50493.jpabel@akkaya.de>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> In recent 2.6 kernels you can simply do a chmod on /proc/cmdline.

Interesting....still, you'd have to
- - chmod /proc/cmdline
- - chmod /var/log/boot.msg
- - klogctl: reset the kernel message ring buffer
- - ...anything else?

seem's like preventing such data from showing up in the first place would be
much more appropriate. Also, what if that data isn't even for root's eye's
(yes, I am security guy)?

jp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBGBL/z6J7R+QJGuwRAhxQAJ9/NBCYiIrR+OiKwBaYtsgQzGS2zACgg7a4
OEESJ4MrRSHq/58HP/Tz/1E=
=sCuy
-----END PGP SIGNATURE-----
