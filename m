Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265266AbUENNG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265266AbUENNG1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 09:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUENNG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 09:06:27 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13799 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265266AbUENNG0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 09:06:26 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] H8/300 IDE support update
Date: Fri, 14 May 2004 15:07:31 +0200
User-Agent: KMail/1.5.3
Cc: linux kernel Mailing List <linux-kernel@vger.kernel.org>
References: <m24qqj9o9j.wl%ysato@users.sourceforge.jp>
In-Reply-To: <m24qqj9o9j.wl%ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405141507.31492.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 14 of May 2004 14:39, Yoshinori Sato wrote:
> - IDE support update.
> - unused memory hole delete.

Yoshinori, this patch doesn't apply to vanilla 2.6.6 / 2.6.6-bk1.

And once again: please do not use ide_default_{irq,io_base}()
and ide_init_hwif_ports() in new IDE code.

Regards,
Bartlomiej

