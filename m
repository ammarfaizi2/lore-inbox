Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130490AbRCIMPy>; Fri, 9 Mar 2001 07:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130491AbRCIMPp>; Fri, 9 Mar 2001 07:15:45 -0500
Received: from zmamail04.zma.compaq.com ([161.114.64.104]:55556 "HELO
	zmamail04.zma.compaq.com") by vger.kernel.org with SMTP
	id <S130490AbRCIMPa>; Fri, 9 Mar 2001 07:15:30 -0500
Reply-To: <frey@cxau.zko.dec.com>
From: "Martin Frey" <frey@scs.ch>
To: <gjohnson@research.canon.com.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Resolving physical addresses
Date: Fri, 9 Mar 2001 07:14:49 -0500
Message-ID: <014601c0a892$8a7b4580$7bc02f10@SCHLEPPDOWN>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
In-Reply-To: <20010309061700.17719.qmail@cass.research.canon.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>But how do I get the physical address out of the page
>structure? It is non-obvious to me. Is there some majic
>macro? We are talking about 'struct page' in mm.h, correct?
>
virt_to_phys(page_address(page))

>Quoth David S. Miller:
>> In 2.4.x pte_page() gives a pointer to a page struct, not an address
>> as in 2.2.x.

-- 
Supercomputing Systems AG       email: frey@scs.ch
Martin Frey                     web:   http://www.scs.ch/~frey/
at Compaq Computer Corporation  phone: +1 603 884 4266
ZKO2-3P09, 110 Spit Brook Road, Nashua, NH 03062

