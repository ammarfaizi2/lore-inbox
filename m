Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVAaMZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVAaMZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 07:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVAaMZo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 07:25:44 -0500
Received: from mailr.eris.qinetiq.com ([128.98.1.9]:35789 "HELO
	mailr.qinetiq-tim.net") by vger.kernel.org with SMTP
	id S261167AbVAaMZc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 07:25:32 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: My System doesn't use swap!
Date: Mon, 31 Jan 2005 12:32:50 +0000
User-Agent: KMail/1.6.1
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Michael Buesch <mbuesch@freenet.de>
References: <41FE1B4B.2060305@tiscali.de> <200501311157.10932.mbuesch@freenet.de> <41FE2814.9030503@tiscali.de>
In-Reply-To: <41FE2814.9030503@tiscali.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200501311232.50935.m.watts@eris.qinetiq.com>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.29.0.5; VDF: 6.29.0.52; host: mailr.qinetiq-tim.net)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Michael Buesch wrote:
> >Quoting Matthias-Christian Ott <matthias.christian@tiscali.de>:
> >>Hi!
> >>I have mysterious Problem:
> >>90 % of my Ram are used (340 MB), but 0 Byte of my Swap (2GB) is used
> >>and about about 150 MB are swappable.
> >>
> >>[matthias-christian@iceowl ~]$ free
> >>             total       used       free     shared    buffers     cached
> >>Mem:        383868     362176      21692          0         12     208956
> >>-/+ buffers/cache:     153208     230660

Note that ~200MB are being used for disk caching.
If your system need to allocate more ram, the disk cache will reduce before 
swap is used.

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB/iVyBn4EFUVUIO0RAmRBAJ46Vk2Z69/i+bMrj1gbSF8obHgEkgCgw8iU
NgRDBYk+YoiRuWZZ2gFT8NE=
=R02H
-----END PGP SIGNATURE-----
