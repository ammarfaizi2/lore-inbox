Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265033AbUE1AWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265033AbUE1AWY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 20:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265202AbUE1AWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 20:22:24 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:1786 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265033AbUE1AWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 20:22:22 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Date: Thu, 27 May 2004 19:40:49 +0200
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040527194920.A1709@jurassic.park.msu.ru> <200405271854.21499.bzolnier@elka.pw.edu.pl> <20040527210821.A2004@jurassic.park.msu.ru>
In-Reply-To: <20040527210821.A2004@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405271940.49386.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 of May 2004 19:08, Ivan Kokshaysky wrote:
> On Thu, May 27, 2004 at 06:54:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > > >>> boot -file new_kernel_image.gz
> >
> > How is it different from reboot?
>
> In this scenario it's not different, except you boot
> to another kernel.

Eh.

> > So how does it work in 2.4?
>
> 2.4 needs similar fix.
>
> > No more <asm/ide.h> crap, please.
>
> Would #ifdef __alpha__ be better?

actually CONFIG_ALPHA + comment why it is needed

Thanks,
Bartlomiej

