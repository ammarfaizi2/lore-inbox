Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136149AbRD0SEu>; Fri, 27 Apr 2001 14:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136148AbRD0SEl>; Fri, 27 Apr 2001 14:04:41 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:60233 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S136144AbRD0SEe>; Fri, 27 Apr 2001 14:04:34 -0400
Message-ID: <3AE9B429.6CCEF680@sgi.com>
Date: Fri, 27 Apr 2001 11:02:17 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <green.mif.pg.gda.pl!kufel!ankry@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SMP race in ext2 - metadata corruption.
In-Reply-To: <200104262113.XAA01552@kufel.dom>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrzej Krzysztofowicz wrote:

> I know a few people that often do:
>
> dd if=/dev/hda1 of=/dev/hdc1
> e2fsck /dev/hdc1
>
> to make an "exact" copy of a currently working system.

---
    Presumably this isn't a problem is the source disks are either unmounted or mounted 'read-only' ?


--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338



