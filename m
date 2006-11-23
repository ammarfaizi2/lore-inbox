Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757279AbWKWLu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757279AbWKWLu4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757351AbWKWLu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:50:56 -0500
Received: from smtp-02.mandic.com.br ([200.225.81.133]:39905 "EHLO
	smtp-02.mandic.com.br") by vger.kernel.org with ESMTP
	id S1757279AbWKWLuz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:50:55 -0500
Message-ID: <45658B19.8010207@mandic.com.br>
Date: Thu, 23 Nov 2006 09:50:49 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.8 (X11/20060911)
MIME-Version: 1.0
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
CC: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: [OT] bug? VFAT copy problem
References: <20061120164209.04417252@localhost>	<877ixqhvlw.fsf@duaron.myhome.or.jp>	<20061120184912.5e1b1cac@localhost>	<87mz6kajks.fsf@duaron.myhome.or.jp>	<1164204175.10427.1.camel@localhost.localdomain>	<20061122145344.GB18141@DervishD> <1164243385.3525.19.camel@monteirov>	<20061123091301.GC21908@DervishD> <87hcwq1jg7.fsf@duaron.myhome.or.jp>
In-Reply-To: <87hcwq1jg7.fsf@duaron.myhome.or.jp>
X-Enigmail-Version: 0.94.1.0
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

OGAWA Hirofumi escreveu:
> Right. FAT's size field is 32bit, so *file* of FAT has limit of 4GB-1.
> (Since directory doesn't have size, in theoretically it can exceed 4GB-1)
> 
> Hm.. Maybe MS added a new hack to FAT..?

Ogawa, MS don't added a new hack to FAT32... This file system don't
support file size with more than 4Gb:
<http://msdn2.microsoft.com/en-us/library/aa365678.aspx>

Best Regards,
- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFZYsZ41FQMNQgUVoRAresAJ0cyYTTOMr9Zrik2ojqquUC8wwEwgCfTe1g
93wBDWCheZSSfMyiBHIfmNc=
=kmsy
-----END PGP SIGNATURE-----
