Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSAHCGO>; Mon, 7 Jan 2002 21:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287511AbSAHCGE>; Mon, 7 Jan 2002 21:06:04 -0500
Received: from [210.176.202.14] ([210.176.202.14]:25740 "EHLO
	uranus.planet.rcn.com.hk") by vger.kernel.org with ESMTP
	id <S286207AbSAHCFq>; Mon, 7 Jan 2002 21:05:46 -0500
Message-ID: <3C3A53EF.7010402@rcn.com.hk>
Date: Tue, 08 Jan 2002 10:05:35 +0800
From: David Chow <davidchow@rcn.com.hk>
Organization: Resources Computer Network Ltd.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: zh_TW, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.4.17 VM question
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

 From 2.4.14, the SetPageDecrAfter() in mm.h is gone.... also it is now 
not called in rw_swap_page_base() in paeg_io.c . The PG_decr_after (5) 
flag is now dissappeared. Now the 5 is replaced with something called 
PG_unused in mm.h . What's the meaning of both? Also the 
rw_swap_page_base() now doesn't check rw==WRITE and where does the WRITE 
handles? Thanks.

David

