Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129091AbQKUIHo>; Tue, 21 Nov 2000 03:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129259AbQKUIHe>; Tue, 21 Nov 2000 03:07:34 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:16400 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129091AbQKUIHT>; Tue, 21 Nov 2000 03:07:19 -0500
Date: Tue, 21 Nov 2000 08:36:59 +0100 (CET)
From: Tomasz K³oczko <kloczek@rudy.mif.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: Linux 2.2.18pre22
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011210831200.22444-200000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="328798250-1007219813-974792219=:22444"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--328798250-1007219813-974792219=:22444
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT

On Sun, 19 Nov 2000, Alan Cox wrote:
[..]
> 2.2.18pre20
[..]
> o	Fix ipv6 procfs bug				(Al Viro)

Seems in this place was introduced small bug.
Linking kernel with disabled CONFIG_SYSCTL fails with:

kernel/kernel.o(__ksymtab+0x5f8): undefined reference to `sysctl_jiffies'

Patch with fix included.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

--328798250-1007219813-974792219=:22444
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sysctl.c_sysctl_intvec.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0011210836590.22444@rudy.mif.pg.gda.pl>
Content-Description: 
Content-Disposition: attachment; filename="sysctl.c_sysctl_intvec.patch"

LS0tIGxpbnV4L2tlcm5lbC9zeXNjdGwuYy5vcmcJVHVlIE5vdiAyMSAwODow
MToyNSAyMDAwDQorKysgbGludXgva2VybmVsL3N5c2N0bC5jCVR1ZSBOb3Yg
MjEgMDg6MDA6MzMgMjAwMA0KQEAgLTExNzMsNiArMTE3MywxMyBAQA0KIAly
ZXR1cm4gLUVOT1NZUzsNCiB9DQogDQoraW50IHN5c2N0bF9qaWZmaWVzKGN0
bF90YWJsZSAqdGFibGUsIGludCAqbmFtZSwgaW50IG5sZW4sDQorCQl2b2lk
ICpvbGR2YWwsIHNpemVfdCAqb2xkbGVucCwNCisJCXZvaWQgKm5ld3ZhbCwg
c2l6ZV90IG5ld2xlbiwgdm9pZCAqKmNvbnRleHQpDQorew0KKwlyZXR1cm4g
LUVOT1NZUzsNCit9DQorDQogaW50IHByb2NfZG9zdHJpbmcoY3RsX3RhYmxl
ICp0YWJsZSwgaW50IHdyaXRlLCBzdHJ1Y3QgZmlsZSAqZmlscCwNCiAJCSAg
dm9pZCAqYnVmZmVyLCBzaXplX3QgKmxlbnApDQogew0K
--328798250-1007219813-974792219=:22444--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
