Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131671AbRCTAhZ>; Mon, 19 Mar 2001 19:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRCTAhP>; Mon, 19 Mar 2001 19:37:15 -0500
Received: from james.kalifornia.com ([208.179.59.2]:38725 "EHLO
	james.kalifornia.com") by vger.kernel.org with ESMTP
	id <S131671AbRCTAg5>; Mon, 19 Mar 2001 19:36:57 -0500
Message-ID: <3AB636A6.44406C2E@kalifornia.com>
Date: Mon, 19 Mar 2001 08:41:10 -0800
From: Ben Ford <ben@kalifornia.com>
X-Mailer: Mozilla 4.73C-CCK-MCD Caldera Systems OpenLinux [en] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: [Fwd: Problem with file => 2GB]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is forwarded from the forensics@securityfocus.com mailing list.  I think you
guys can answer this question better.  Please cc: them in any replies.

-b



"Fabio Pietrosanti (naif)" wrote:

> Hi ppl,
> i'm currently involved in the analisys of a compromised linux box.
> It was a IBM xSeries server.
>
> I transfer the partition of the server using cat /dev/partition| nc
> host_of_dump_storage 8889, then i check the checksum using md5sum and all it's
> ok.
>
> Where's the problem?
>
> There are 2 partition dump of 8GB .
> So i have to mount another 30GB hd, i installed Linux Kernel 2.4.2 with the
> 30gb on reiserfs .
> I recompiled all fileutils, util-linux and bin-utils with kernel 2.4.2 and the
> define for => 2GB file support .
>
> Ok, now i could download the partition, i could ls, more, strings the
> partition, but i need to use it as loop device!!
>
> When i mount the partition as loop device the mount command HANG on read()
> function... it seems that loop device under linux didn't work against => 2gb
> files ?
>
> Any solutions?
>
> Best Regards
>
> --
> Pietrosanti  Fabio          I.NET SpA, High Quality Access to the Internet
> e-mail:  naif@inet.it       ( Direzione Tecnica, Security Staff )
>          firewall@inet.it
> PGP Key (DSS)               http://naif.itapac.net/naif.asc
>
> Home Page URL:            http://www.inet.it
> Sede:                     Via Darwin, 85 20019 Settimo Milanese (MI)
> Tel:                      02-328631   Fax: 02-328637701
> --
> Free advertising: www.openbsd.org - Multiplatform Ultra-secure OS

