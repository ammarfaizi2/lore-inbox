Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129152AbQKSKiD>; Sun, 19 Nov 2000 05:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129157AbQKSKhy>; Sun, 19 Nov 2000 05:37:54 -0500
Received: from e35.marxmeier.com ([194.64.71.4]:31248 "EHLO e35.marxmeier.com")
	by vger.kernel.org with ESMTP id <S129152AbQKSKhn>;
	Sun, 19 Nov 2000 05:37:43 -0500
Message-ID: <3A17A667.EED80785@marxmeier.com>
Date: Sun, 19 Nov 2000 11:07:35 +0100
From: Michael Marxmeier <mike@marxmeier.com>
Organization: Marxmeier Software AG
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre22
In-Reply-To: <E13xJ14-0002Do-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile failed:

megaraid.c: In function `mega_findCard':
megaraid.c:1906: warning: implicit declaration of function
`pci_resource_start'

drivers/scsi/scsi.a(megaraid.o): In function `mega_findCard':
megaraid.o(.text+0x19a7): undefined reference to `pci_resource_start'

Seems a #include <linux/kcomp.h> is missing here.


Michael

-- 
Michael Marxmeier           Marxmeier Software AG
E-Mail: mike@marxmeier.com  Besenbruchstrasse 9
Phone : +49 202 2431440     42285 Wuppertal, Germany
Fax   : +49 202 2431420     http://www.marxmeier.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
