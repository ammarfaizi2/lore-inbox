Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264897AbUE0RJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264897AbUE0RJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUE0RJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:09:10 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1410 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264893AbUE0RIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:08:23 -0400
Date: Thu, 27 May 2004 21:08:21 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6] don't put IDE disks in standby mode on halt on Alpha
Message-ID: <20040527210821.A2004@jurassic.park.msu.ru>
References: <20040527194920.A1709@jurassic.park.msu.ru> <200405271854.21499.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405271854.21499.bzolnier@elka.pw.edu.pl>; from B.Zolnierkiewicz@elka.pw.edu.pl on Thu, May 27, 2004 at 06:54:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 06:54:21PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > >>> boot -file new_kernel_image.gz
> 
> How is it different from reboot?

In this scenario it's not different, except you boot
to another kernel.

> So how does it work in 2.4?

2.4 needs similar fix.

> No more <asm/ide.h> crap, please.

Would #ifdef __alpha__ be better?

Ivan.
