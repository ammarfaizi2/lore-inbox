Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264671AbUEXSWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264671AbUEXSWK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 14:22:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbUEXSWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 14:22:10 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:23168 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP id S264671AbUEXSWH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 14:22:07 -0400
Message-ID: <40B23D4A.4010708@free.fr>
Date: Mon, 24 May 2004 20:22:02 +0200
From: baptiste coudurier <baptiste.coudurier@free.fr>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MORE THAN 10 IDE CONTROLLERS
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello

Im trying to use more than 10 ide controllers on a 2.4.26 kernel and i
did not succeed.

i patched already according to several posts (Alan Cox) so now i get :

PDC20269: ROM enabled at 0xfdee0000
~    idea: BM-DMA at 0xdf50-0xdf57, BIOS settings: hdu:pio, hdv:pio
~    ideb: BM-DMA at 0xdf58-0xdf5f, BIOS settings: hdw:pio, hdx:pio

but unfortunately :

ide1 at 0x170-0x177,0x376 on irq 15
ide3 at 0xdfa0-0xdfa7,0xdfaa on irq 23
ideb: UNABLE TO GET MAJOR NUMBER 0

i guess i need to patch major and minor numbers for the devices as well
but i did not reach to.

i search into Documentation/devices.txt without sucess.

Does anyone know what are major/minors for hdu, hdv, hdw, hdx ?

Thks a lot for your help.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQCVAwUBQLI9SQrJMlxcGrqqAQKpNwP/Q+YvqeK0VaRHsv+K54cQ8DXK3D2374x8
KpUJ4Tp7Aj3hgPA9eepDP+fxlbiZ36ppl8Mu4L173uClRxQwI7nET9O8lpYIyZLz
oDVSBJYfIUb+iRuBHgldJTt6x7FHboSiIw80MNgoGgF2/iVYOIack0xGUCSJBCji
ilswRk1d874=
=y89h
-----END PGP SIGNATURE-----
