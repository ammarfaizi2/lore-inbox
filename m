Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbTKRTHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 14:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbTKRTHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 14:07:55 -0500
Received: from smtp04.web.de ([217.72.192.208]:8483 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263768AbTKRTHw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 14:07:52 -0500
From: dodger <shoxx@web.de>
Reply-To: shoxx@web.de
Organization: none.org
To: linux-kernel@vger.kernel.org
Subject: Re: problem with suspend to disk on linux2.6-t9
Date: Tue, 18 Nov 2003 19:38:59 +0100
User-Agent: KMail/1.5.4
References: <200311172327.24418.shoxx@web.de> <200311180718.00059.rob@landley.net>
In-Reply-To: <200311180718.00059.rob@landley.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311181939.09727.shoxx@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 18 November 2003 14:18, Rob Landley wrote:
> Did you specify a default resume partition (CONFIG_PM_DISK_PARTITION) in
> your .config?  (Or provide it with the kernel parameter
> pmdisk=/dev/blah)...

yes i did.
i tried to suspend with disabled hdb write cache ( hdparm -W0 /dev/hdb ) and 
it suspended and resumed fine.
exept for my network device wasnt running...is there a way to fix this?
i`ll try to do   ifdown before suspending and ifup after resuming, but is 
there a way to resume properly without that?

dodger
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/umdKN+skZni2ETYRAnP9AJ9BgIfL5vwar1xJP1HqcjKkXezOcgCfSplv
7Vhwik+TieywXjgO2NWnXUQ=
=4Db2
-----END PGP SIGNATURE-----

