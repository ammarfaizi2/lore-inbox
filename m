Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312980AbSC0I7I>; Wed, 27 Mar 2002 03:59:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312981AbSC0I65>; Wed, 27 Mar 2002 03:58:57 -0500
Received: from web13105.mail.yahoo.com ([216.136.174.150]:40462 "HELO
	web13105.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S312980AbSC0I6h>; Wed, 27 Mar 2002 03:58:37 -0500
Message-ID: <20020327085836.19129.qmail@web13105.mail.yahoo.com>
Date: Wed, 27 Mar 2002 00:58:36 -0800 (PST)
From: kcratie <kcratie@yahoo.com>
Subject: identifying swap partitions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day,
There doesn't seem to be any facility available to a
module to obtain information about swap devices in the
2.4.7 kernel. I have attempted to use
"is_swap_partition" and "swap_info" in swapfile.c but
my module fails to load stating unresolved symbol.
I've searched /proc/ksyms and neither is there, and
since I'm using both optimization and modversions I'm
assuming that it is not exported for use. Is this
correct, if so is there some alternative call that can
be used to obtain the information?
One additional request, please cc your
answers/comments to kcratie@yahoo.com 
Thank you,
Ken Subratie

__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
