Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262520AbUKQUDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUKQUDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbUKQUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:01:57 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:49341 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S262525AbUKQT7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 14:59:12 -0500
Date: Wed, 17 Nov 2004 14:58:50 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: [Request for inclusion] Filesystem in Userspace
In-reply-to: <Pine.LNX.4.53.0411171908260.29426@yvahk01.tjqt.qr>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Nikita Danilov <nikita@clusterfs.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Message-id: <419BAD7A.6040303@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org>
 <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
 <84144f0204111602136a9bbded@mail.gmail.com>
 <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
 <20041116120226.A27354@pauline.vellum.cz>
 <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com>
 <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
 <16795.33515.187015.492860@thebsh.namesys.com>
 <Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr>
 <16795.35688.634029.21478@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0411171837250.15704@yvahk01.tjqt.qr>
 <16795.37202.793499.93514@gargle.gargle.HOWL>
 <Pine.LNX.4.53.0411171908260.29426@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:
>>Unless, of course, by "polluted" you mean that output of "cat
>>/proc/self/mounts" becomes longer.
> 
> 
> Precisely that. I recall there once was "you're exceeding the maximum number of
> filesystems" or such, has that "bug"/"non-feature" been lifted?
> 

Two issues are resolved in current 2.6:

  - /proc/mounts used to be limitted to a page of data, fixed mid 2.4
  - there used to be a limit of pseudo-block backed filesystems in a
system, which was fixed by distros by using multiple majors, fixed
properly in 2.6.4-rc1


- --
Mike Waychison
Sun Microsystems, Inc.
1 (650) 352-5299 voice
1 (416) 202-8336 voice

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
NOTICE:  The opinions expressed in this email are held by me,
and may not represent the views of Sun Microsystems, Inc.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBm616dQs4kOxk3/MRAgmbAJ9M9h6/Jp94h9cAr3u167CFLSa/5QCfYng3
w6QNoKtus1zExR7pRXXhVqQ=
=23z1
-----END PGP SIGNATURE-----
