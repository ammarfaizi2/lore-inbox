Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVAQJ5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVAQJ5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 04:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVAQJ5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 04:57:04 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:58516 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S262754AbVAQJ4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 04:56:52 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org, <jyri.poldre@artecdesign.ee>
Subject: Re: Ethernet driver link state propagation to ip stack
Date: Mon, 17 Jan 2005 10:03:43 +0000
User-Agent: KMail/1.6.1
References: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
In-Reply-To: <JJEGJLLALGANNBPNAIMMOEGLDGAA.jyri.poldre@artecdesign.ee>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200501171003.43595.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> All,
>
> I am experiencing issues with connecting two network adapters to the same
> subnet, eg.
>
> eth0 192.168.100.200
> eth1 192.168.100.201
>
> The task is to have redundant connections to two different hubs. In case
> one link goes down the connection should go through the other.

Use the bonding.o driver. This scenario is _exactly_ what it's designed for 
(when mode=1)

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB641/Bn4EFUVUIO0RAsN6AKC3SdnVTlnJ8XDB+bn6yIUf563rNwCeJaGc
qwPKo+ucugBZsXtn0Olve2A=
=UQSS
-----END PGP SIGNATURE-----
