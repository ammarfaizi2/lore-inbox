Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbUL0WBR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbUL0WBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261480AbUL0WBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:01:17 -0500
Received: from pop.gmx.net ([213.165.64.20]:23769 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261460AbUL0WBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:01:14 -0500
X-Authenticated: #23921511
Message-ID: <41D08611.9000004@gmx.de>
Date: Mon, 27 Dec 2004 23:00:49 +0100
From: "prem.de.ms" <prem.de.ms@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: 2.6.10 compile error - blackbird_load_firmware
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I get the following error message when I try to compile the new 
2.6.10-kernel:

[...]
CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x8a3b2): In function `blackbird_load_firmware':
: undefined reference to `request_firmware'
drivers/built-in.o(.text+0x8a454): In function `blackbird_load_firmware':
: undefined reference to `release_firmware'
make: *** [.tmp_vmlinux1] Error 1

Seems like the Conexant drivers are broken because the kernel compiles 
when I uncheck them.

Any suggestions?
