Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750717AbWFEHeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWFEHeq (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 03:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWFEHeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 03:34:46 -0400
Received: from wx-out-0102.google.com ([66.249.82.202]:3506 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750717AbWFEHeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 03:34:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=N6IbksWbu8Sy7B9znpnjtpnlKpcZioAmnWzZCy2Xxo0cmCk2TKijK9ViILaKkLhpkh5ce6KneSOwxNRzvWA2QrFHvKgzFhFAc46pYPr2ipj1owel4Goy35+vRdC+Qkjjk8psXwJrY0FgnButYa6feahRRqhpgcNH4ppMQ5218Qk=
Message-ID: <a44ae5cd0606050034p288424cbs329575c16421a459@mail.gmail.com>
Date: Mon, 5 Jun 2006 00:34:45 -0700
From: "Miles Lane" <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.17-rc5-mm3 -- Various section mismatches in processor.o, wistron_btns.o and jffs2.o
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know Andrew has said there are thousands of these warnings,
but I wasn't clear whether that meant I should not report them.
The ones shown below haven't been mentioned by others on
LKML for recent MM kernel trees, afaics.

WARNING: drivers/acpi/processor.o - Section mismatch: reference to
.init.data: from .text between 'acpi_processor_power_init' (at offset
0x142f) and 'acpi_processor_cst_has_changed'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x120) and 'keymap_aopen_1559as'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x14c) and 'keymap_aopen_1559as'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x178) and 'keymap_aopen_1559as'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x1a4) and 'keymap_aopen_1559as'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x1d0) and 'keymap_aopen_1559as'
WARNING: drivers/input/misc/wistron_btns.o - Section mismatch:
reference to .init.text:dmi_matched from .data between 'dmi_ids' (at
offset 0x1fc) and 'keymap_aopen_1559as'
WARNING: fs/jffs2/jffs2.o - Section mismatch: reference to
.exit.text:jffs2_zlib_exit from .text between 'jffs2_compressors_exit'
(at offset 0x88) and 'jffs2_decompress'
