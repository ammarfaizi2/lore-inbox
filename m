Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274635AbRJAGxz>; Mon, 1 Oct 2001 02:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274636AbRJAGxf>; Mon, 1 Oct 2001 02:53:35 -0400
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:41490 "EHLO
	zmamail04.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S274635AbRJAGxY>; Mon, 1 Oct 2001 02:53:24 -0400
Subject: /proc/slabinfo doesn't give details of what it is showing.
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 01 Oct 2001 12:24:01 +0530
Message-Id: <1001919241.1075.9.camel@satan.xko.dec.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi , 

 If will be really nice to list out what these values are when one does 

 $more /proc/slabinfo. It is just a one line code that busy people
really don't have time to look into :) Any how here is the one line code
with some lines above. 


      len += sprintf(page+len, "slabinfo - version: 1.1"
#if STATS
                                " (statistics)"
#endif
#ifdef CONFIG_SMP
                                " (SMP)"
#endif
                                "\n");
        len += sprintf(page+len,
"(cache-name)-----(num-active-objs)--(total-objs)--(obj-size)--(num-active-slabs)--(total-slabs)--(num-pages-per-slab)\n");

 -aneesh 




