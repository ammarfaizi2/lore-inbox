Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbVGDKdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbVGDKdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 06:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVGDKdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 06:33:45 -0400
Received: from ws6-4.us4.outblaze.com ([205.158.62.107]:9390 "HELO
	ws6-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261240AbVGDKdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 06:33:24 -0400
Message-ID: <42C91073.80900@grimmer.com>
Date: Mon, 04 Jul 2005 12:33:23 +0200
From: Lenz Grimmer <lenz@grimmer.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]
 IBM HDAPS Someone interested? (Accelerometer))
References: <9a8748490507031832546f383a@mail.gmail.com> <42C8D06C.2020608@grimmer.com> <20050704061713.GA1444@suse.de> <42C8C978.4030409@linuxwireless.org> <20050704063741.GC1444@suse.de> <1120461401.3174.10.camel@laptopd505.fenrus.org> <20050704072231.GG1444@suse.de> <1120462037.3174.25.camel@laptopd505.fenrus.org> <20050704073031.GI1444@suse.de>
In-Reply-To: <20050704073031.GI1444@suse.de>
X-Enigmail-Version: 0.91.0.0
OpenPGP: id=B27291F2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

Jens Axboe wrote:

> It isn't too pretty to rely on such unreliable timing anyways. I'm 
> not too crazy about spinning the disk down either, it's useless wear 
> compared to just parking the head.

Fully agreed, and that's the approach the IBM Windows driver seems to
take - you just hear the disk park its head when the sensor kicks in
(you can hear it) - the disk does not spin down when this happens.

Could this be some reserved ATA command that only works with certain#
drives?

Bye,
	LenZ
- --
- ------------------------------------------------------------------
 Lenz Grimmer <lenz@grimmer.com>                             -o)
 [ICQ: 160767607 | Jabber: LenZGr@jabber.org]                /\\
 http://www.lenzg.org/                                       V_V
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCyRBySVDhKrJykfIRAkM+AJ9UDbO8JU48UcEgVE2Kf35X1f4PjgCfaNPx
xEHnSU5BagtmC02nwGx66F4=
=BDfq
-----END PGP SIGNATURE-----
