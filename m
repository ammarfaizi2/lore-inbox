Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbVLHTWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbVLHTWk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 14:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVLHTWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 14:22:40 -0500
Received: from ns1.heckrath.net ([213.239.205.18]:28853 "EHLO
	mail.heckrath.net") by vger.kernel.org with ESMTP id S1750873AbVLHTWj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 14:22:39 -0500
Date: Thu, 8 Dec 2005 20:23:37 +0100
From: Sebastian =?ISO-8859-15?Q?K=E4rgel?= <mailing@wodkahexe.de>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.{14,15-rc4} harddrive cache not detected
Message-Id: <20051208202337.e3798191.mailing@wodkahexe.de>
In-Reply-To: <58cb370e0512081105x68e855e4n98312b1f3a25abab@mail.gmail.com>
References: <20051208194408.77e17f64.mailing@wodkahexe.de>
	<58cb370e0512081105x68e855e4n98312b1f3a25abab@mail.gmail.com>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2005 20:05:37 +0100
Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> wrote:

> I think that I've seen before some other Toshiba
> disks that incorrectly report cache size.
> 
> Could you send /proc/ide/hda/identify?

Hello,

# cat /proc/ide/hda/identify
0040 3fff c837 0010 0000 0000 003f 0000
0000 0000 2020 2020 2020 2020 2020 2059
3535 4c37 3338 3253 0000 0000 0030 4b41
3130 3041 2020 544f 5348 4942 4120 4d4b
3430 3235 4741 5320 2020 2020 2020 2020
2020 2020 2020 2020 2020 2020 2020 8010
0000 2f00 4000 0200 0000 0007 3fff 0010
003f fc10 00fb 0110 5300 04a8 0007 0007
0003 0078 0078 0078 0078 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
007e 0000 7c6b 5908 4003 7c69 1808 4003
043f 0012 0000 0080 fffe 604b 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0001 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 0000
0000 0000 0000 0000 0000 0000 0000 77a5

Hope this helps.

Thanks, Sebastian
