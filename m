Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261997AbUKPO6c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261997AbUKPO6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 09:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbUKPO45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 09:56:57 -0500
Received: from sv1.lisha.ufsc.br ([150.162.62.1]:46497 "EHLO sv1.lisha.ufsc.br")
	by vger.kernel.org with ESMTP id S261998AbUKPO43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:56:29 -0500
From: Thiago Robert dos Santos <robert@lisha.ufsc.br>
Message-ID: <33231.150.162.62.34.1100616986.squirrel@150.162.62.34>
Date: Tue, 16 Nov 2004 12:56:26 -0200 (BRDT)
Subject: PCI mapper
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a-0.f1.1
X-Mailer: SquirrelMail/1.4.3a-0.f1.1
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20041116125626_73366"
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_20041116125626_73366
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

All,


  I have developed a module that maps a given device's memory into user
space.
The module is very simple (see the source code attached). It just
defines the following file operations: open, release, ioctl and mmap.

   I'm having a problem in porting this module to the 2.6 series.
Apparently, everything is working fine but I just can't access the
device's memory (even tough I get a valid point from the mmap system
call).

    Can anyone help me?


Thanks in advance.

------=_20041116125626_73366
Content-Type: text/x-csrc; name="pcimap.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.c"


------=_20041116125626_73366
Content-Type: text/x-chdr; name="pcimap.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap.h"


------=_20041116125626_73366
Content-Type: text/x-chdr; name="debug.h"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="debug.h"


------=_20041116125626_73366
Content-Type: application/octet-stream; name="Makefile"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Makefile"


------=_20041116125626_73366
Content-Type: text/x-csrc; name="pcimap_test.c"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="pcimap_test.c"


------=_20041116125626_73366--

