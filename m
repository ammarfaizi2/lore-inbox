Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132063AbRAASTv>; Mon, 1 Jan 2001 13:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132084AbRAASTl>; Mon, 1 Jan 2001 13:19:41 -0500
Received: from staff.cs.usyd.edu.au ([129.78.8.1]:992 "helo
	staff.cs.usyd.edu.au") by vger.kernel.org with SMTP
	id <S132063AbRAASTh>; Mon, 1 Jan 2001 13:19:37 -0500
X-Claimed-Received: from cs.usyd.edu.au
Message-ID: <3A50C32C.91350CB@cs.usyd.edu.au>
Date: Tue, 02 Jan 2001 04:49:32 +1100
From: Mark James <mrj@cs.usyd.edu.au>
Organization: The University of Sydney
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: netfilter enum conflict?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi:

include/linux/netfilter_ipv4.h and include/linux/netfilter_ipv6.h
both define enum nf_ip_hook_priorities.  This trips the compiler
if both are included.  Should one change to nf_ipv6_hook_priorities?

Mark
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
