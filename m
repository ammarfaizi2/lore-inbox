Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264595AbUGNOpB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264595AbUGNOpB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267398AbUGNOmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:42:35 -0400
Received: from atlas.fs.tum.de ([129.187.202.11]:49859 "EHLO atlas.fs.tum.de")
	by vger.kernel.org with ESMTP id S264595AbUGNOka (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:40:30 -0400
Date: Wed, 14 Jul 2004 16:40:25 +0200 (CEST)
From: Florian Echtler <echtler@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: console initialization differences between 2.6.2 and .7?
Message-ID: <Pine.LNX.4.58.0407141629300.29998@valhalla.fs.tum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone,

I've just built a 2.6.7 kernel for a diskless machine and noticed
that simple stuff like init=/bin/sash stopped working. The output
to the console stops after "Freeing unused kernel memory". It only
works when using a full-blown init process. 

I compiled and statically linked a small program doing nothing but 
'printf("Hello.\n");', which shows output on my laptop using 2.6.2 when 
passed as init=/test, but not on the other machine with 2.6.7.
Because there is no kernel panic like "init not found", I assume the 
program which I specified has indeed been run as init replacement.

Can anyone shed any light on this problem?
Please CC me in the answer, as I am not a member of the list.

TIA, Yours,
Florian
- -- 
Homo homini lupus.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA9UXc7CzyshGvatgRApfhAJ4iVcx4mRODSKSVmFWIf5IDNE+SJACffcH+
91rZ5GwVgEVtqNDBNabbNZs=
=nTQv
-----END PGP SIGNATURE-----
