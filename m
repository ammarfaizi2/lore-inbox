Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264090AbRFKLqC>; Mon, 11 Jun 2001 07:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264091AbRFKLpn>; Mon, 11 Jun 2001 07:45:43 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:61875 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S264090AbRFKLpd>; Mon, 11 Jun 2001 07:45:33 -0400
Message-ID: <3B24AF66.3010602@AnteFacto.com>
Date: Mon, 11 Jun 2001 12:45:42 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; rv:0.9.1) Gecko/20010607
X-Accept-Language: en-us
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: kernel list <linux-kernel@vger.kernel.org>, jffs-dev@axis.com
Subject: Re: jffs on non-MTD device?
In-Reply-To: <20010525005253.A16005@bug.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some (most?) CF disks have hareware wareleveling.
I use ext2 with e2compr patch.

Padraig.

Pavel Machek wrote:

>Hi!
>
>I'm trying to run jffs on my ATA-flash disk (running ext2 could kill
>some flash cells too soon, right?) but it refuses:
>
>        if (MAJOR(dev) != MTD_BLOCK_MAJOR) {
>                printk(KERN_WARNING "JFFS: Trying to mount a "
>                       "non-mtd device.\n");
>                return 0;
>        }
>
>What are reasons for this check?
>
>								Pavel
>


