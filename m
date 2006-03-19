Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWCSVrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWCSVrC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 16:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbWCSVrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 16:47:01 -0500
Received: from femail.waymark.net ([206.176.148.84]:54678 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1751111AbWCSVrA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 16:47:00 -0500
Date: 19 Mar 2006 21:01:10 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: dnotify
To: linux-kernel@vger.kernel.org
Message-ID: <7039e4.737825@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        With kernel 2.6.16-rc6-git10 dnotify support active 'vmstat
10' shows a constant 200+ context switches on an idle system when the
midnight commander 'mc' file manager is opened in an rxvt, but only the
usual few context switches with dnotify removed, inotify support present
in both cases. I dont know if this is normal and expected behavior,
and if not, when it may have changed, but it seems a bit high context
switches rate, eh?

:6! ldd /usr/bin/mc
        libglib-2.0.so.0 => /usr/lib/libglib-2.0.so.0 (0xb7ed9000)
        libext2fs.so.2 => /lib/libext2fs.so.2 (0xb7ec1000)
        libcom_err.so.2 => /lib/libcom_err.so.2 (0xb7ebe000)
        libgpm.so.1 => /lib/libgpm.so.1 (0xb7eb8000)
        libslang.so.1 => /usr/lib/libslang.so.1 (0xb7e47000)
        libnsl.so.1 => /lib/libnsl.so.1 (0xb7e32000)
        libc.so.6 => /lib/libc.so.6 (0xb7d03000)
        libncurses.so.5 => /lib/libncurses.so.5 (0xb7cc4000)
        libdl.so.2 => /lib/libdl.so.2 (0xb7cc1000)
        libm.so.6 => /lib/libm.so.6 (0xb7c9f000)
        /lib/ld-linux.so.2 => /lib/ld-linux.so.2 (0xb7f67000)

... Come home America.
--- MultiMail/Linux v0.47
