Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSEYTv2>; Sat, 25 May 2002 15:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSEYTv1>; Sat, 25 May 2002 15:51:27 -0400
Received: from adsl.hlfl.org ([62.212.107.116]:36100 "HELO adsl.hlfl.org")
	by vger.kernel.org with SMTP id <S315275AbSEYTv1>;
	Sat, 25 May 2002 15:51:27 -0400
Date: Sat, 25 May 2002 21:51:26 +0200
From: Arnaud Launay <asl@launay.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.18] Modules unresolved symbols
Message-ID: <20020525215126.A340@launay.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Vanilla 2.5.18 gives me the following unresolved symbols:


depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/acpi/acpi_thermal.o
depmod:         acpi_processor_set_thermal_limit
depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/drivers/ide/ide-mod.o
depmod:         blk_get_request
depmod: *** Unresolved symbols in /lib/modules/2.5.18/kernel/fs/ext2/ext2.o
depmod:         write_mapping_buffers

For ide-mod and ext2, it was already there in 2.5.17.

	Arnaud.
