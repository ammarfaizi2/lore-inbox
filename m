Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269389AbUINMsZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269389AbUINMsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269421AbUINMmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:42:20 -0400
Received: from palma.portsdebalears.com ([195.53.243.35]:27050 "EHLO
	cochise.portsdebalears.com") by vger.kernel.org with ESMTP
	id S269414AbUINMls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:41:48 -0400
Date: Tue, 14 Sep 2004 14:41:44 +0200
From: Kiko Piris <kernel@pirispons.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.8-rc1] lost DMA on my Intel 82801EB (ICH5) Serial ATA 150 Storage Controller
Message-ID: <20040914124144.GA3960@fpirisp.portsdebalears.com>
Mail-Followup-To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20040914063537.GA3954@fpirisp.portsdebalears.com> <200409141412.35827.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409141412.35827.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt
X-No-CC: Please respect my Mail-Followup-To header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2004 at 14:12 +0200, Bartlomiej Zolnierkiewicz wrote:

> always cc: linux-ide@vger.kernel.org on ATA stuff

OK.

> you need CONFIG_BLK_DEV_IDE_SATA

That was it, it works now. The help message of that option confused me.

Thanks a lot.

-- 
Kiko
Private mail is preferred encrypted:
http://www.pirispons.net/pgpkey.html
