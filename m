Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261214AbRELIvO>; Sat, 12 May 2001 04:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261215AbRELIuy>; Sat, 12 May 2001 04:50:54 -0400
Received: from colorfullife.com ([216.156.138.34]:45836 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S261214AbRELIuw>;
	Sat, 12 May 2001 04:50:52 -0400
Message-ID: <3AFCF932.A2EAEC74@colorfullife.com>
Date: Sat, 12 May 2001 10:49:54 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, acpi@phobos.fachschaften.tu-muenchen.de
Subject: APCI oops with 2.4.4-ac8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-2.4.4-ac8
old bios, no complete acpi support.

from dmesg:
<<<<<<
ACPI: System description tables not found
Unable to handle kernel NULL pointer dereference at virtual address
000000d4

EIP: acpi_get_timer+19
Call trace: bm_initialize
		bm_osl_init
<<<<<

acpi_gbl_FADT is NULL.

If you need additional details just ask.

--
	Manfred
