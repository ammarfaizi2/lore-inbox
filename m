Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965614AbWKDUWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965614AbWKDUWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 15:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965638AbWKDUWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 15:22:25 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:48396 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965614AbWKDUWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 15:22:25 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc4-mm2
Date: Sat, 4 Nov 2006 21:20:54 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061101235407.a92f94a5.akpm@osdl.org>
In-Reply-To: <20061101235407.a92f94a5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611042120.55094.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	After allyesconfig I found this on one of my box'es. Not sure how to fix 
that. Don't want to mess with headers ;-)

  CC      drivers/media/video/pwc/pwc-uncompress.o
In file included from drivers/media/video/pwc/pwc-uncompress.c:29:
include/asm/current.h: In function `get_current':
include/asm/current.h:11: error: `size_t' undeclared (first use in this 
function)
include/asm/current.h:11: error: (Each undeclared identifier is reported only 
once
include/asm/current.h:11: error: for each function it appears in.)
make[4]: *** [drivers/media/video/pwc/pwc-uncompress.o] Error 1
make[3]: *** [drivers/media/video/pwc] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

Regards,

	Mariusz Kozlowski
