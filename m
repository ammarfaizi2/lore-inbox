Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270203AbTGRKgT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271532AbTGRKgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:36:19 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:24630 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S270203AbTGRKgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 06:36:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: devfsd/2.6.0-test1
Date: Fri, 18 Jul 2003 11:49:55 +0100
User-Agent: KMail/1.4.3
Cc: Thierry Vignaud <tvignaud@mandrakesoft.com>, linux-kernel@vger.kernel.org
References: <200307172145.14681.arvidjaar@mail.ru>
In-Reply-To: <200307172145.14681.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307181149.55663.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> >> tv@vador ~ $ urpmf /etc/modprobe.devfs
> >> module-init-tools:/etc/modprobe.devfs
> >
> > Interesting, an urpmf for that on my 9.1 box reveals nothing...
>
> the package is in cooker since today. Get SRPMs for modutils, devfsd and
> module-init-tools, compile and install.

Ok, I've got those and I now have a modules.devfs...
I'm getting the impression that a bunch of modules have changed their names 
(i810_audio for example).
Even though I've changed (or I think I have) these module names in 
modprobe.conf I'm seeing failures for loading the old ones... Is something 
reading modules.conf that shouldn't?

Cheers,

Mark.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/F9DTBn4EFUVUIO0RAh9jAJ4hX6y6+rwDDOSsIfzm9MQMl+hIkwCeJsOa
rXjtNYZe/ZvOx+waW1+mOd4=
=udld
-----END PGP SIGNATURE-----

