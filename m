Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274992AbTHLDaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 23:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274997AbTHLDaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 23:30:13 -0400
Received: from smartmail.hjemme.no ([213.188.18.138]:24297 "EHLO
	smartmail.hjemme.no") by vger.kernel.org with ESMTP id S274992AbTHLDaL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 23:30:11 -0400
Date: Tue, 12 Aug 2003 05:32:44 +0200
From: Andreas Mikkelborg <andreas.mikkelborg@hjemme.no>
To: linux-kernel@vger.kernel.org
Subject: Error in videodev.c with 2.6.0-test3-mm1.
Message-Id: <20030812053244.47252991.andreas.mikkelborg@hjemme.no>
Organization: na
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CC [M]  drivers/media/video/videodev.o
drivers/media/video/videodev.c:398: `video_proc_entry' undeclared here (not in a function)
drivers/media/video/videodev.c:398: initializer element is not constant
drivers/media/video/videodev.c:398: (near initialization for `__ksymtab_video_proc_entry.value')
make[3]: *** [drivers/media/video/videodev.o] Error 1
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2
