Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbTIJQ6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 12:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265276AbTIJQ6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 12:58:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:7892 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265270AbTIJQ6V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 12:58:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: juranj1@feld.cvut.cz
Subject: Re: setting dma on on hdd
Date: Wed, 10 Sep 2003 19:00:27 +0200
User-Agent: KMail/1.5
References: <1063187533.3f5ef44d16576@imap.feld.cvut.cz>
In-Reply-To: <1063187533.3f5ef44d16576@imap.feld.cvut.cz>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309101900.27941.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 of September 2003 11:52, juranj1@feld.cvut.cz wrote:
> when i use a kernel 2.4.20-8 that works fine
> somewhere i founded that problem could be in driver Uniform Multi-Platform
> E-IDE driver Revision: 7.00beta4-2.4 which is in 2.4.22, but i dont know
> how shoud i solve this problem..thank you for every advice....(i think that
> i have compiled everthing what i shoud)

You don't have support for you IDE chipset compiled in the kernel.
You should add something like "CONFIG_BLK_DEV_PIIX=y" to your .config file.

This issue was discussed several times on lkml,
please search archives for more info.

--bartlomiej

