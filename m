Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310971AbSCHRYf>; Fri, 8 Mar 2002 12:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310970AbSCHRYZ>; Fri, 8 Mar 2002 12:24:25 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:12238 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S310971AbSCHRYO>; Fri, 8 Mar 2002 12:24:14 -0500
Message-ID: <3C88F211.3090504@antefacto.com>
Date: Fri, 08 Mar 2002 17:17:05 +0000
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: androsyn@ratbox.org
CC: linux-kernel@vger.kernel.org
Subject: linux 2.4.18 fails to load static /bin/init
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I noticed this problem when trying to boot 2.4.18 on a Netra t1 200.
 > Basically what will happen is the kernel will mount / read-only, then try
 > to load /sbin/init, at which point it hangs.  If I a dynamically linked
 > wrapper around /sbin/init then all is happy and the system boots fine.
 >
 > Any ideas or clues?

Sounds like you statically linked against the wrong libc?

Padraig.

