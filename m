Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264246AbRFOFWp>; Fri, 15 Jun 2001 01:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264248AbRFOFWg>; Fri, 15 Jun 2001 01:22:36 -0400
Received: from [202.54.26.202] ([202.54.26.202]:35235 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S264246AbRFOFWP>;
	Fri, 15 Jun 2001 01:22:15 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Ramil.Santamaria@tais.toshiba.com
cc: linux-kernel@vger.kernel.org
Message-ID: <65256A6C.001C10BE.00@sandesh.hss.hns.com>
Date: Fri, 15 Jun 2001 10:44:25 +0530
Subject: Re: Buddy System bitmaps
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



well... I doubt whether buddy allocator would take u to a situation where pages
0 and 2 are used and 1 and 3 are free...
try reading __get_free_pages in mm/page_alloc.c




Ramil.Santamaria@tais.toshiba.com on 06/15/2001 12:39:20 AM

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Amol Lad/HSS)

Subject:  Buddy System bitmaps




Hi,

For this scenario consider a set of 4 page frames.
Frames 0 and 2 are used while frames 1 and 3 are free.

The question is would the bitmap for order 1 be a 1 or 0 for this scenario.

I am not on the list so please cc me on your response.

Thanks in advance.

Ramil J.Santamaria
Toshiba America Information Systems
(949) 461-4379
(949) 206-3439 - fax
ramil.santamaria@tais.toshiba.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




