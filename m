Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264733AbUEPUSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264733AbUEPUSd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 16:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbUEPUSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 16:18:33 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:19688 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264736AbUEPUSa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 16:18:30 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@redhat.com>, Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [RFT][PATCH] ide-disk.c: more write cache fixes
Date: Sun, 16 May 2004 22:20:23 +0200
User-Agent: KMail/1.5.3
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Alan Cox <alan@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>,
       Jens Axboe <axboe@suse.de>
References: <200405132116.44201.bzolnier@elka.pw.edu.pl> <40A4B482.3040706@keyaccess.nl> <20040516195811.GH20505@devserv.devel.redhat.com>
In-Reply-To: <20040516195811.GH20505@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405162220.23971.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 of May 2004 21:58, Alan Cox wrote:
> On Fri, May 14, 2004 at 01:58:58PM +0200, Rene Herman wrote:
> > Have again attached a 'rollup' patch against vanilla 2.6.6, including
> > this, Andrew's SYSTEM_SHUTDOWN split and the quick "don't switch of
> > spindle if rebooting" hack. Again, just in case anyone finds it useful.
>
> This reintroduces corruption on my thinkpad 600.

[ this corruption was fixed by kernel 2.6.6 ]

Please see if reverting changes to ide_device_shutdown() helps.

