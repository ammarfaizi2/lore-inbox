Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264404AbUFDAWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264404AbUFDAWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 20:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265007AbUFDAWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 20:22:44 -0400
Received: from webmail.cs.unm.edu ([64.106.20.39]:39657 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S264404AbUFDAWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 20:22:43 -0400
Message-ID: <40BFCA4C.2000904@cs.unm.edu>
Date: Thu, 03 Jun 2004 19:03:08 -0600
From: Sushant Sharma <sushant@cs.unm.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: modifying struct sk_buff
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1BW2Tj-0005I5-00*VNpWp25vi7k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I want to add a new member (say uint32_t) in the
struct sk_buff{...}
in the file include/linux/skbuff.h.

If i add this new member and I want to assign it
some value when ever function
struct sk_buff *alloc_skb(unsigned int *size,* int gfp_mask)
in file
net/core/skbuff.c
is called
Do I need to allocate memory for this member
(  ie add sizeof(_new-member_) to *size* while doing kmalloc()  )
or I should not worry abt that and I can assign some value
to this _new-member_ every time this function is called.

Thanks
Sushant

