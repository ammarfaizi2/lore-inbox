Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267471AbTACJYX>; Fri, 3 Jan 2003 04:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267472AbTACJYX>; Fri, 3 Jan 2003 04:24:23 -0500
Received: from pheniscidae.tvnetwork.hu ([80.95.85.58]:15111 "EHLO
	pheniscidae.TvNetWork.Hu") by vger.kernel.org with ESMTP
	id <S267471AbTACJYX>; Fri, 3 Jan 2003 04:24:23 -0500
Date: Fri, 3 Jan 2003 10:32:50 +0100
From: SZALAY Attila <sasa@pheniscidae.tvnetwork.hu>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.54
Message-ID: <20030103093250.GC7661@sasa.home>
References: <20030102103422.GB24116@sasa.home> <Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L2.0301020745260.22868-100000@dragon.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 2003 Jan 02, Randy.Dunlap wrote:
> 
> Yes, unfortunately this is a well-known problem.
> See kernel.bugzilla.org # 126 and # 164.
> 
> You need to have CONFIG_INPUT=y, not =m.

Thank you, it's work.

But I have another problem.

drivers/message/i2o/i2o_lan.c:28: #error Please convert me to Documentation/DMA-mapping.txt
drivers/message/i2o/i2o_lan.c:119: parse error before `struct'
drivers/message/i2o/i2o_lan.c: In function 	2o_lan_receive_post_reply':
drivers/message/i2o/i2o_lan.c:385: `run_i2o_post_buckets_task' undeclared (first use in this function)
drivers/message/i2o/i2o_lan.c:385: (Each undeclared identifier is reported only once
drivers/message/i2o/i2o_lan.c:385: for each function it appears in.)
drivers/message/i2o/i2o_lan.c: In function 	2o_lan_register_device':
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1406: structure has no member named `list'
drivers/message/i2o/i2o_lan.c:1407: structure has no member named `sync'
make[4]: *** [drivers/message/i2o/i2o_lan.o] Error 1
make[3]: *** [drivers/message/i2o] Error 2
make[2]: *** [drivers/message] Error 2
make[1]: *** [drivers] Error 2


-- 
PGP ID 0x8D143771, /C5 95 43 F8 6F 19 E8 29  53 5E 96 61 05 63 42 D0
GPG ID   ABA0E8B2, 45CF B559 8281 8091 8469  CACD DB71 AEFC ABA0 E8B2

                          Szeretem a Zsanit - SaSa
