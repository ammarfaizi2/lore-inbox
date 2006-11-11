Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424286AbWKKQT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424286AbWKKQT4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424272AbWKKQT4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:19:56 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:23000 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424286AbWKKQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:19:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iu9yoNDrxpFvXOAkHo4MCAjsOVGbKZmnGulu4Ihq0cyUg2Gv/++coJ1erMfPmellt88Pb+qYX8sgVAn6aMIwOnMIie5yzID49RHtZO0wGdlWIWkGtqWX0cXnPKzA7QU7DVc6Rb1JuoU5w2RgcJmcst/WJdC90yjqCQ0B0VP3F9w=
Message-ID: <4d8e3fd30611110819r7e4dc941od93b9eb1220f2992@mail.gmail.com>
Date: Sat, 11 Nov 2006 17:19:53 +0100
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       video4linux-list@redhat.com,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Adrian Bunk" <bunk@stusta.de>
Subject: [TRIVIAL PATCH] Added information about Technisat Sky2Pc cards - take 3
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This is the third time I submit the below patch (first sent on the
29th of October), I'm adding lkml and Adrian since this is really
trivial.

We hope it will be applied since it really helps people using Sky2Pc cards.

Thanks in advance.

Cheers,

Paolo

Signed-off-by: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Acked-by: Daniele Vallini <vallinidaniele@libero.it>
---
 Documentation/dvb/cards.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dvb/cards.txt b/Documentation/dvb/cards.txt
index ca58e33..cc09187 100644
--- a/Documentation/dvb/cards.txt
+++ b/Documentation/dvb/cards.txt
@@ -22,10 +22,10 @@ o Frontends drivers:
   - ves1x93           : Alps BSRV2 (ves1893 demodulator) and dbox2 (ves1993)
   - cx24110           : Conexant HM1221/HM1811 (cx24110 or cx24106
demod, cx24108 PLL)
   - grundig_29504-491 : Grundig 29504-491 (Philips TDA8083
demodulator), tsa5522 PLL
-   - mt312             : Zarlink mt312 or Mitel vp310 demodulator,
sl1935 or tsa5059 PLL
+   - mt312             : Zarlink mt312 or Mitel vp310 demodulator,
sl1935 or tsa5059 PLLi, Technisat Sky2Pc with bios Rev. 2.3
   - stv0299           : Alps BSRU6 (tsa5059 PLL), LG TDQB-S00x (tsa5059 PLL),
                         LG TDQF-S001F (sl1935 PLL), Philips SU1278
(tua6100 PLL),
-                         Philips SU1278SH (tsa5059 PLL), Samsung TBMU24112IMB
+                         Philips SU1278SH (tsa5059 PLL), Samsung
TBMU24112IMB, Technisat Sky2Pc with bios Rev. 2.6
  DVB-C:
   - ves1820           : various (ves1820 demodulator, sp5659c or spXXXX PLL)
   - at76c651          : Atmel AT76c651(B) with DAT7021 PLL
