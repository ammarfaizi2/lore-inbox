Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313238AbSEVNQt>; Wed, 22 May 2002 09:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSEVNQr>; Wed, 22 May 2002 09:16:47 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:2508 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S313238AbSEVNQn>; Wed, 22 May 2002 09:16:43 -0400
Message-ID: <3CEB9A1B.9040905@antefacto.com>
Date: Wed, 22 May 2002 14:16:11 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <Pine.LNX.4.44.0205202211040.949-100000@home.transmeta.com> <3CEB5F75.4000009@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> Remove support for /dev/port altogether.

FYI:

[root@pixelbeat padraig]# find /bin /usr/bin /lib /sbin /usr/sbin 
/usr/lib -maxdepth 1 -type f -perm +111 | xargs grep -l "/dev/port"
/sbin/hwclock: util-linux
/sbin/kbdrate: util-linux
/bin/watchdog: ;-)

Padraig.

