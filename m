Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263952AbTDWEPl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 00:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTDWEPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 00:15:41 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:47206 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id S263952AbTDWEPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 00:15:40 -0400
Date: Wed, 23 Apr 2003 06:27:44 +0200 (CEST)
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [SPARC64] 2.5.68-bk3: problems compiling Creator 3D fb and drm
Message-ID: <Pine.LNX.4.53.0304230620020.12279@trider-g7.ext.fabbione.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
	as in the Subject:

drivers/char/drm/drm_drv.h: In function `drm_init':
drivers/char/drm/drm_drv.h:550: warning: unused variable `retcode'
drivers/char/drm/ffb_drv.c: At top level:
drivers/char/drm/ffb_drv.c:386: redefinition of `ffb_options'
drivers/char/drm/drm_drv.h:138: `ffb_options' previously defined here
{standard input}: Assembler messages:
{standard input}:3018: Error: symbol `ffb_options' is already defined
make[3]: *** [drivers/char/drm/ffb_drv.o] Error 1
make[2]: *** [drivers/char/drm] Error 2
make[1]: *** [drivers/char] Error 2
make: *** [drivers] Error 2

Both fbdev and drm are compiled in.

Thanks
Fabio
