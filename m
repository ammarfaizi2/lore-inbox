Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132503AbRAQKLj>; Wed, 17 Jan 2001 05:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132311AbRAQKLa>; Wed, 17 Jan 2001 05:11:30 -0500
Received: from mailout02.sul.t-online.com ([194.25.134.17]:13574 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S132212AbRAQKLT>; Wed, 17 Jan 2001 05:11:19 -0500
Message-ID: <3A656FBC.5E284B26@t-online.de>
Date: Wed, 17 Jan 2001 11:11:08 +0100
From: Jeffrey.Rose@t-online.de (Jeffrey Rose)
Organization: http://ChristForge.SourceForge.net/
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Gennerat <christian.gennerat@vz.cit.alcatel.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 config breaks /dev/fd0* major/minor ?
In-Reply-To: <3A656749.ACF3F01A@t-online.de> <3A6567CF.E10FDEBD@mandrakesoft.com> <3A656E59.424842E2@vz.cit.alcatel.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Gennerat wrote:
> 
> Jeff Garzik a écrit :
> 
> > Jeffrey Rose wrote:
> > > I get a wrong major/minor reported when attempting
> > > to mount /dev/fd0 ...
> >
> > Sounds like it can't find the floppy driver, for whatever reason...
> >
> 
> I have seen this message, new with 2.4.0-2mdk
> (before I have 2.4.0-0.15mdk)
> but only on one PC.
> I have 2 PC, with same hardware, same PCMCIA config
> The first have mandrake 7.2 Odissey, and the modules
> floppy and floppy_cs are loaded, and /mnt/floppy is mounted
> The second have mandrake 7.1 Helium, and the modules
> fail during init. and I have this message:
> 'mount: /dev/fd0 has wrong major or minor number'
> 
> Problem of compatibility of some library?

Still checking ...

I also want to mention that the physical drive light *does* indicate
partial success at some level of access, but mounting fails due to the
major/minor problem. I am trying to determine if this is a kernel-CONFIG
or a kernel-SPECIFIC problem I have encountered with this 2.4.0 upgrade.

Jeff
-- 
<Jeffrey.Rose@t-online.de>
KEYSERVER=wwwkeys.de.pgp.net
SEARCH STRING=Jeffrey Rose
KEYID=6AD04244
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
