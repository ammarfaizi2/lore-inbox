Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270271AbTGWNG7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 09:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270272AbTGWNG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 09:06:59 -0400
Received: from ns0.eris.qinetiq.com ([128.98.1.1]:27248 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S270271AbTGWNGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 09:06:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: andersen@codepoet.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Promise SATA driver GPL'd
Date: Wed, 23 Jul 2003 14:20:28 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <20030722184532.GA2321@codepoet.org> <20030722185443.GB6004@gtf.org> <20030722190705.GA2500@codepoet.org>
In-Reply-To: <20030722190705.GA2500@codepoet.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200307231420.28717.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Tue Jul 22, 2003 at 02:54:43PM -0400, Jeff Garzik wrote:
> > Bart, Alan, and I have been looking at this.  It uses the ancient CAM
> > model, that we don't really want to merge directly in the kernel.  It's
> > very close to the libata model, from the user perspective, so life is
> > good.
>
> I was reading over your libata driver yesterday.  Certainly a lot
> cleaner than the cam stuff IMHO.  Given the info made available
> via the Promise driver, I expect that I could get an initial
> libata host adaptor driver hacked together in short order.  After
> all, the Intel one is just 400 lines.  So unless you (or anyone
> else) have already started or would prefer to do the honors,
> I'll try to hack something together this evening,
>
>  -Erik


Oooh Oooh!!!!

I have an onboard Promise SATA chip - the 30276 (its on an MSI KT4A Ultra 
board), which gives me two SATA and one PATA ports (only use 2 at a time)...

If you want someone to test...  I can slap a PATA drive onto the PATA port, 
but I've been holding off getting any SATA drives until I can use them under 
linux, although I'm running out of drive space so this is quite timely... :)

Cheers,

Mark

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/HoucBn4EFUVUIO0RAmwjAJ9/IY3N+AdOdNmfKwPkPoXfDw+PEgCgm7XD
tR56nTVC9b0u8aBZMhWaTag=
=QsVB
-----END PGP SIGNATURE-----

