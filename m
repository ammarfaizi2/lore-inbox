Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263797AbUDMWtd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 18:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUDMWtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 18:49:33 -0400
Received: from w130.z209220038.sjc-ca.dsl.cnc.net ([209.220.38.130]:15869 "EHLO
	mail.inostor.com") by vger.kernel.org with ESMTP id S263797AbUDMWtb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 18:49:31 -0400
Message-ID: <407C6E49.8040000@inostor.com>
Date: Tue, 13 Apr 2004 15:48:41 -0700
From: Tom Dickson <tdickson@inostor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040406
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Does 2.4.25 fix spurious "Serverworks OSB4 in impossible state"
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm running 2.4.20, and every once in a while I get the "Serverworks
Chipset in impossible state."

But I have the following:

ServerWorks CSB5: IDE controller on PCI bus 00 dev 79
ServerWorks CSB5: chipset revision 147
ServerWorks CSB5: not 100% native mode: will probe irqs later

which shouldn't trigger that warning, right?

Will I have to upgrade to 2.4.25 fix this, or is there a simple patch I
can apply to 2.4.20 to prevent this lockup from occuring?

ide=nodma is way too slow for my purposes, though it seems to work.

- -Tom
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFAfG5I2dxAfYNwANIRAlywAKCjX+0lEbXwTpO8rv6Fs+WY0v7pgACfT7Ro
1msiavEyuvMp4/0KzS+ngpA=
=O8wO
-----END PGP SIGNATURE-----
