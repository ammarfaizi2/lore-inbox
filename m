Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbUDHWm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 18:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUDHWm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 18:42:26 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:6575 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262898AbUDHWli
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 18:41:38 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] QD65xx I/O ports
Date: Fri, 9 Apr 2004 00:50:24 +0200
User-Agent: KMail/1.5.3
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
References: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0404061330470.4158@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404090050.24841.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 of April 2004 13:31, Geert Uytterhoeven wrote:
> I/O port numbers can be larger than 8-bit on many platforms (this caused a
> warning when {out,in}b() cast reg to a pointer on platforms with memory
> mapped I/O)

Was VESA Local Bus ever used on something else than 486?
I think it's better to just add "depends on X86" to drivers/ide/Kconfig.

Cheers,
Bartlomiej

