Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318959AbSIIVAu>; Mon, 9 Sep 2002 17:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318960AbSIIVAu>; Mon, 9 Sep 2002 17:00:50 -0400
Received: from mail.dts.de ([212.62.75.8]:58897 "HELO dtsroot.dts.intra")
	by vger.kernel.org with SMTP id <S318959AbSIIVAs>;
	Mon, 9 Sep 2002 17:00:48 -0400
Message-ID: <3D7D0D02.6060604@dts.de>
Date: Mon, 09 Sep 2002 23:05:06 +0200
From: Andreas Kerl <andreas.kerl@dts.de>
Reply-To: andreas.kerl@dts.de
Organization: DTS Medien GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: de, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: compile error 2.4.20.pre5-ac4 
X-Enigmail-Version: 0.65.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/ide/idedriver.o: In function `proc_ide_read_drivers':
drivers/ide/idedriver.o(.text+0x4c9): undefined reference to `ide_modules'
drivers/ide/idedriver.o: In function `proc_ide_read_identify':
drivers/ide/idedriver.o(.text+0x791): undefined reference to 
`taskfile_lib_get_identify'
drivers/ide/idedriver.o: In function `proc_ide_read_settings':
drivers/ide/idedriver.o(.text+0x8ca): undefined reference to 
`ide_read_setting'
drivers/ide/idedriver.o: In function `proc_ide_write_settings':
drivers/ide/idedriver.o(.text+0xb44): undefined reference to 
`ide_find_setting_by_name'
drivers/ide/idedriver.o(.text+0xb9e): undefined reference to 
`ide_write_setting'
drivers/ide/idedriver.o: In function `proc_ide_write_driver':
drivers/ide/idedriver.o(.text+0xea0): undefined reference to 
`ide_replace_subdriver'
drivers/ide/idedriver.o: In function `create_proc_ide_drives':
drivers/ide/idedriver.o(.text+0x110b): undefined reference to 
`generic_subdriver_entries'
drivers/ide/idedriver.o: In function `create_proc_ide_interfaces':
drivers/ide/idedriver.o(.text+0x12c5): undefined reference to `ide_hwifs'
drivers/ide/idedriver.o: In function `destroy_proc_ide_interfaces':
drivers/ide/idedriver.o(.text+0x1338): undefined reference to `ide_hwifs'
make: *** [vmlinux] Fehler 1

