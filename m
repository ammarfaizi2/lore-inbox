Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261159AbTFEJuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 05:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbTFEJuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 05:50:17 -0400
Received: from ns0.eris.dera.gov.uk ([128.98.1.1]:15162 "HELO
	ns0.eris.dera.gov.uk") by vger.kernel.org with SMTP id S261159AbTFEJuQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 05:50:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Geller Sandor <wildy@petra.hos.u-szeged.hu>
Subject: Re: Linux 2.4.21-rc7-ac1
Date: Thu, 5 Jun 2003 10:57:46 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0306051117050.24047-100000@petra.hos.u-szeged.hu>
In-Reply-To: <Pine.LNX.4.44.0306051117050.24047-100000@petra.hos.u-szeged.hu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306051057.46382.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Thu, 5 Jun 2003, Mark Watts wrote:
> > I wonder if you could confirm whether the usb-ohci module should be
> > loaded automatically if I have the following line in modules.conf (this
> > is with 2.4.21-rc6-ac2)
> >
> > probeall usb-interface usb-ohci
>
> No. You have to modprobe 'usb-interface' somewhere in your rc scripts.
> See the manpage for modules.conf
>
> What distribution are you using?

Mandrake 9.1

>
> In debian, /etc/modules contains the modules, which are loaded at system
> startup.

I've never needed to put it into /etc/modules before, so maybe Mandrake does 
it differently.

I'll try that - thanks

Mark.

- -- 
Mark Watts
Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+3xQaBn4EFUVUIO0RAu5WAJ9FRh1szMYDBAa921t2caLoqE+mVQCfVkvG
1Sx9/mWvGrTl+2Hu7MSB5S8=
=OtZc
-----END PGP SIGNATURE-----

