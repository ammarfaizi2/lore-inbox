Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLVS3C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTLVS3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:29:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:37352 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262228AbTLVS26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:28:58 -0500
Date: Mon, 22 Dec 2003 10:27:18 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>
Subject: [PATCH] {doc} add SpeedStep zero-page usage
Message-Id: <20031222102718.3f792b35.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please queue with 2.6.0++ patches.


description:	add Intel SpeedStep zero-page memory usage doc.
product_versions: Linux 2.6.0

diffstat:=
 Documentation/i386/zero-page.txt |    1 +
 1 files changed, 1 insertion(+)

diff -Naurp ./Documentation/i386/zero-page.txt~ist-reserve ./Documentation/i386/zero-page.txt
--- ./Documentation/i386/zero-page.txt~ist-reserve	2003-12-17 18:58:40.000000000 -0800
+++ ./Documentation/i386/zero-page.txt	2003-12-22 10:16:45.000000000 -0800
@@ -22,6 +22,7 @@ Offset	Type		Description
 			  0x90000 + contents of CL_OFFSET
 			(only taken, when CL_MAGIC = 0xA33F)
  0x40	20 bytes	struct apm_bios_info, APM_BIOS_INFO
+ 0x60	16 bytes	Intel SpeedStep (IST) BIOS support information
  0x80	16 bytes	hd0-disk-parameter from intvector 0x41
  0x90	16 bytes	hd1-disk-parameter from intvector 0x46
 



--
~Randy
