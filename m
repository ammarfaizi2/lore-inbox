Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbULNNlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbULNNlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 08:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbULNNlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 08:41:37 -0500
Received: from imap.gmx.net ([213.165.64.20]:35544 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261508AbULNNlK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 08:41:10 -0500
Date: Tue, 14 Dec 2004 14:41:06 +0100 (MET)
From: "Alexander Stohr" <Alexander.Stohr@gmx.de>
To: gibbs@scsiguy.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary102201103031666"
Subject: [PATCH] linux 2.6.x (current)  - fix compiler warning on aic7xxx/aic79xx_osm.c
X-Priority: 3 (Normal)
X-Authenticated: #15156664
Message-ID: <10220.1103031666@www21.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary102201103031666
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

attached patch fixes two warnings of gcc 3.3.3 about unused symbols
when compiling the aic79xxx sources as a monolitic component
of the linux kernel instead of creating a module out of it.

the patch was done against todays bitkeeper snapshot 2.6.10-rc3-bk8
and consists of a single, simple "#ifdef MODULE"/"#endif" pair around 
those two reported static vars.

-Alex.

-- 
GMX ProMail mit bestem Virenschutz http://www.gmx.net/de/go/mail
+++ Empfehlung der Redaktion +++ Internet Professionell 10/04 +++
--========GMXBoundary102201103031666
Content-Type: application/octet-stream; name="linux-2.6.10-rc3-bk8-fix-aic-module.diff.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.10-rc3-bk8-fix-aic-module.diff.bz2"

QlpoOTFBWSZTWdkId+0AAOBfgAIweP///3733k6/79/gQAGnNiVhoRNTJjSm1PKaNPI00JoGhoMI
0NMI8oAlU9BPU1GU/U9UeRqABoAANAANAGQ5pkZDJghowmCNNGjEDTJkYAAglRTNEZGhoAAAAAAA
AADgGkap236jkxwM4gaWbJrXCRUsIQicPhrJpqtNASKOPrwvviWTfoeSzVrMGHsFeBlhgqPY030U
1dGRr2ITwhWfzxDAxAw4JS8CcT0xhe4uJ+gwhgJYT91RZIMh6D9iJSGmw8h4UJfg2DWMHFh4JK4u
RCI6KMrrILChSUjAaFzkHblLqBUwg/2wriUUu3kRtBiJ4hjaUkxWB2AsXDaiO3npOUXsoCCkTfNh
ZbwrcW3WYcxmxOhVBGTxu3dxZtpsc2erqG9vSItnNN5I8O7tApO90jKBAYCSKzCvQ5f8BcAqrF/I
TrElAQiGiELwkFfeq4D9jXzuiUBaOuytZZWxGP953ZKasjQWTs5GInqKwwfc7Y0B+81V+EwSJJaU
ZVnsLzGWArxCbRCKs21C4Fqtir7YKZUfVW4FmhkUNiRVCJBGiTjkugZDjcRobFEoyoAWEtwkFWnB
jwQ06gbrB0VRK5ikKEbBG2y/mxVj7+wXWox0JPvPoSnRs+/mgnOIGSGFlAjqg2AtQ/i7kinChIbI
Q79o

--========GMXBoundary102201103031666--

