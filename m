Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbRFVCUe>; Thu, 21 Jun 2001 22:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265311AbRFVCUX>; Thu, 21 Jun 2001 22:20:23 -0400
Received: from smarty.smart.net ([207.176.80.102]:45573 "EHLO smarty.smart.net")
	by vger.kernel.org with ESMTP id <S265255AbRFVCUM>;
	Thu, 21 Jun 2001 22:20:12 -0400
From: Rick Hohensee <humbubba@smarty.smart.net>
Message-Id: <200106220230.WAA11443@smarty.smart.net>
Subject: mktime in include/linux
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Jun 2001 22:30:40 -0400 (EDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does Linux have a mktime routine fully coded in linux/time.h that
conflicts directly with the ANSI C standard library routine of the same
name? It breaks a couple things against libc5, including gcc 3.0. OK, you
don't care about libc5. It's still pretty weird. Wierd? Weird.

Rick Hohensee
www.cLIeNUX.com

:;d -d */
Cintpos/     boot/        device/      incoming/    owner/       temp/
Debian/      command/     floppy/      log/         source/
Linux/       configure/   guest/       lost+found/  subroutine/
NetBSD/      dev/         help/        mounts/      suite/
:; cLIeNUX /dev/tty12  22:00:52   /
:;


