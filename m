Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTK1CXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbTK1CXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:23:41 -0500
Received: from mx1.verat.net ([217.26.64.139]:49025 "EHLO mx1.verat.net")
	by vger.kernel.org with ESMTP id S261892AbTK1CWb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:22:31 -0500
From: Toplica =?utf-8?q?Tanaskovi=C4=87?= <toptan@verat.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Support for KT400 AGP x8 + ATI drivers
Date: Fri, 28 Nov 2003 03:12:42 +0100
User-Agent: KMail/1.5.93
References: <1154.217.1.100.75.1069852084.squirrel@www.syntheticsw.com>
In-Reply-To: <1154.217.1.100.75.1069852084.squirrel@www.syntheticsw.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Message-Id: <200311280312.44945.toptan@verat.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 26.11.2003 14:08, Torsten Giebl wrote:
> I am using a VIA Board with KT400 chipset, AGP x8 (v3)
> and the commercial ATI drivers for my Radeon 9600.
>
> The standard 2.4.22 Kernel had the problem that AGP v3 was
> not supported and AGPGart was not able to detect the AGP mem size.
>
> My question is now is there a patch for the latest stable kernel
> or do i have to use the dev. kernel ?

	You do not need such patch, ATI's drivers come with their internal AGP
support.
	During installation (rpm or after during fglrxconfig) you are asked if you
would like to use internal or external agpgart. Use internal...

- --
Regards,
Toplica Tanasković
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/xq8ctKJqksC6c0sRArQuAJ9Hq0+gfngjd7aV8QhtiP0Tu4ZvFQCgiGPF
7DE3WtZRakxo8utUBdSPn4o=
=qGMR
-----END PGP SIGNATURE-----
