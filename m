Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWG0OaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWG0OaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbWG0OaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:30:18 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:13223 "EHLO
	fmmailgate02.web.de") by vger.kernel.org with ESMTP
	id S1751367AbWG0OaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:30:16 -0400
Message-ID: <44C8CDF7.4070205@web.de>
Date: Thu, 27 Jul 2006 16:30:15 +0200
From: "jens m. noedler" <noedler@web.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060713)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH] update kernel-parameters.txt
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

This is just a little documentation update which applies to 2.6.18-rc2.

Kind regards, Jens Nödler



Signed-off-by: jens m. noedler <noedler@web.de>

- ---

- --- Documentation/kernel-parameters.txt.orig    2006-07-26 16:47:34.000000000 +0200
+++ Documentation/kernel-parameters.txt 2006-07-27 15:57:02.000000000 +0200
@@ -110,6 +110,13 @@ be entered as an environment variable, w
 it will appear as a kernel argument readable via /proc/cmdline by programs
 running once the system is up.

+The number of kernel parameters in not limited, but the length of the
+complete command line (parameters including spaces etc.) is limited to
+a fixed number of characters. This limit depends on the architecture
+and is between 256 and 4096 characters. It is defined in the file
+./include/asm/setup.h as COMMAND_LINE_SIZE.
+
+
        53c7xx=         [HW,SCSI] Amiga SCSI controllers
                        See header of drivers/scsi/53c7xx.c.
                        See also Documentation/scsi/ncr53c7xx.txt.


- -- 
jens m. noedler
  noedler@web.de
  pgp: 0x9f0920bb
  http://noedler.de

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEyM33BoFc9p8JILsRAgTOAJ45DvSeR8cHMpfznKG8qe9TdDonkQCcDjd6
7GhmbrxbldwsG4f8DoxeXP4=
=RqY3
-----END PGP SIGNATURE-----
