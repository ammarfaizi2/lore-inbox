Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTBCTDQ>; Mon, 3 Feb 2003 14:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBCTDQ>; Mon, 3 Feb 2003 14:03:16 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:3823 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266996AbTBCTDP>;
	Mon, 3 Feb 2003 14:03:15 -0500
Date: Mon, 03 Feb 2003 11:03:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Haverkamp <markh@osdl.org>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mjb3 (scalability / NUMA patchset)
Message-ID: <316530000.1044299003@flay>
In-Reply-To: <1044298502.29532.8.camel@markh1.pdx.osdl.net>
References: <19270000.1038270642@flay><134580000.1039414279@titus> <32230000.1039502522@titus><568990000.1040112629@titus> <21380000.1040717475@titus> <821470000.1041579423@titus> <214500000.1041821919@titus> <676880000.1042101078@titus> <922170000.1042183282@titus> <437220000.1042531505@titus> <190030000.1042787514@titus> <19610000.1043137151@titus> <20200000.1043806571@flay>  <125620000.1044238081@[10.10.2.4]> <1044297228.29537.5.camel@markh1.pdx.osdl.net>  <315150000.1044297722@flay> <1044298502.29532.8.camel@markh1.pdx.osdl.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What gcc are you using? I'm betting 3.2 ... 2.95 seems to work fine.
> 
> You are right, I am using:
> 
> gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
> 
> 
>> (still might be an issue with the patch, just trying to track it down)

Could you find the definition of cpu_online_map, and remove the "=1"
initialisation from it ... see if that fixes it? (I just added that)
Seems suspiciously closely related ... if that doesn't do it, I'll 
try to diagnose here.

Thanks,

M.


