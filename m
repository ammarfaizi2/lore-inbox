Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTEGSeI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTEGSeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:34:08 -0400
Received: from mail.skjellin.no ([80.239.42.67]:49800 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S264198AbTEGSeH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:34:07 -0400
From: "Andre Tomt" <andre@tomt.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.21-rc1 "breaks" older procps
Date: Wed, 7 May 2003 20:48:47 +0200
Message-ID: <000d01c314c9$4afb96d0$0a01ff0a@slurv>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel gurus.

The IDE changes that went into 2.4.21-pre seems to make older procps
unhappy, at least the one in Debian 3.0r1 (latest stable). Upgrading to
a newer procps seems to fix this, but is this breakage really needed?
"Breaking" stable debian userland is not very nice :-)

I thought about notifying the debian maintainers instead, but somehow I
have this feeling this is just a little fixable detail in the kernel.

Yes, I'm 100% sure this system.map (both actually) is matching the
running kernel.

$ ps aux
{ide_dma_intr} {GPLONLY_ide_dma_intr}
Warning: /boot/System.map-2.4.21-rc1-s3 does not match kernel data.
{ide_dma_intr} {GPLONLY_ide_dma_intr}
Warning: /usr/src/linux/System.map does not match kernel data.
USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
<snip>

-- 
Cheers,
André Tomt

