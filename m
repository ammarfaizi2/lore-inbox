Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbTE3Vaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 17:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTE3Vaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 17:30:52 -0400
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:14198 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264070AbTE3Vav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 17:30:51 -0400
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: <lk@trolloc.com>
Subject: Re: siimage driver status
Date: Fri, 30 May 2003 16:44:12 -0500
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.33.0305301156510.17286-100000@ip-64-7-1-79.dsl.lax.megapath.net>
In-Reply-To: <Pine.LNX.4.33.0305301156510.17286-100000@ip-64-7-1-79.dsl.lax.megapath.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305301644.14880.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


This is the exact problem i have with onboard siimage (asus a7n8x)
 or a siimage controller card on a abit motherboard. (kt7a)

echo "max_kb_per_request:15" > /proc/ide/hde/settings
is a work around for 2.4.XX.

				Bob

> I get two console messages before the machine locks hard:
> hde: dma_timer_expiry: dma status == 0x22
> hde: dma_timer_expiry status = 0xd8 { Busy }
>
> I'd love to get this tracked down...
>
>
> Brian.
>
> -----------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+19CuxJgsCy9JAX0RArvcAJ9JdNeIAGCcDvrSSqvam6XgPklm9ACfSPx5
M+JgErtFM9OoqP/6yZuMxnQ=
=q97p
-----END PGP SIGNATURE-----

