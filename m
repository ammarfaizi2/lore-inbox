Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290878AbSBLJv7>; Tue, 12 Feb 2002 04:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290881AbSBLJvt>; Tue, 12 Feb 2002 04:51:49 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:5568 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290878AbSBLJvh>; Tue, 12 Feb 2002 04:51:37 -0500
Message-Id: <200202120950.g1C9ooce002431@tigger.cs.uni-dortmund.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Kernel Janitors <kernel-janitor-discuss@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk prefix cleanups. 
In-Reply-To: Message from Zwane Mwaikambo <zwane@linux.realnet.co.sz> 
   of "Tue, 12 Feb 2002 08:26:15 +0200." <Pine.LNX.4.44.0202120823200.27768-100000@netfinity.realnet.co.sz> 
Date: Tue, 12 Feb 2002 10:50:49 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@linux.realnet.co.sz> said:
> Here is a simple patch which reduces resultant binary size by 1.2k for 
> this particular module (opl3sa2). Perhaps we should consider adding this 
> on the janitor TODO list for cleaning up other printks.

I don't see how changing "opl3sa2: stuff" to "opl3sa2" ": " "stuff" (which
is what you want to get after preprocesing, and which gcc will happily
concatenate to give exactly the former before doing anything else) can
change the size in any way...
-- 
Horst von Brand			     http://counter.li.org # 22616
