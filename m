Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271364AbTHHOOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTHHOOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:14:10 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:34865 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S271364AbTHHOOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:14:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Innovision EIO DM-8301H/R SATA cards...
Date: Fri, 8 Aug 2003 15:11:27 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200308081408.16564.m.watts@eris.qinetiq.com> <3F33A3EB.9030108@pobox.com>
In-Reply-To: <3F33A3EB.9030108@pobox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308081511.28238.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Mark Watts wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> >
> > My local supplier has started doing some SATA cards....
> >
> > http://www.ivmm.com/eio/products_sata_pci_host.html
> >
> >
> > The chip on the board i the screenshot looks vaguely like a Silicon Image
> > chip - - am I correct in thinking that these are supported in linux?
>
> If they are Silicon Image, yes, they are supported.

Great stuff - can someone confirm whether I still need to do the folloing for 
the latest 2.4.22 kernels in order to get good performance?

# hdparm -d1 -X66 /dev/hdX
# echo "max_kb_per_request:15" > /proc/.ide/hdX/settings

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

iD8DBQE/M6+QBn4EFUVUIO0RAsTlAJ47iXTKk7/VUEk/V5AdLe/5FcJODwCg+9MK
lli1yAzptbJho+gqpF/zxHc=
=DSWc
-----END PGP SIGNATURE-----

