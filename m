Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVAFHLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVAFHLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 02:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVAFHLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 02:11:21 -0500
Received: from mail.coware.com ([63.236.49.244]:47234 "EHLO CoWare.com")
	by vger.kernel.org with ESMTP id S262762AbVAFHLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 02:11:18 -0500
Message-ID: <41DCE48E.5010604@coware.com>
Date: Thu, 06 Jan 2005 08:11:10 +0100
From: Harald Dunkel <harald@CoWare.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10: "[permanent]" modules?
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi folks,

Seems that for 2.6.10 I cannot unload ide modules.
'lsmod | grep permanent" lists

ide_generic             1152  0 [permanent]
siimage                12480  0 [permanent]
aec62xx                 7296  0 [permanent]
trm290                  4228  0 [permanent]
alim15x3               10572  0 [permanent]
hpt34x                  5184  0 [permanent]
hpt366                 20032  0 [permanent]
cmd64x                 11996  0 [permanent]
piix                   10052  0 [permanent]
rz1000                  2496  0 [permanent]
slc90e66                5568  0 [permanent]
generic                 3968  0 [permanent]
cs5530                  4672  0 [permanent]
cs5520                  4672  0 [permanent]
sc1200                  7168  0 [permanent]
triflex                 3648  0 [permanent]
atiixp                  6032  0 [permanent]
pdc202xx_old           11264  0 [permanent]
pdc202xx_new            9088  0 [permanent]
opti621                 4420  0 [permanent]
ns87415                 3720  0 [permanent]
cy82c693                4416  0 [permanent]
amd74xx                12508  0 [permanent]
sis5513                14280  0 [permanent]
via82cxxx              11996  0 [permanent]
serverworks             7624  0 [permanent]

Is this on purpose?

2bsure, module unloading is enabled in my .config


Regards

Harri
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3OSOUTlbRTxpHjcRAkKXAKCPu+7E4L/XxNTE1skyTvy7NUUcdACbBSu9
sAxceT0jHylMiEmL9KBkWXA=
=t0JI
-----END PGP SIGNATURE-----
