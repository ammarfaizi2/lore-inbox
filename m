Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281440AbRKPOw2>; Fri, 16 Nov 2001 09:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281441AbRKPOwT>; Fri, 16 Nov 2001 09:52:19 -0500
Received: from samar.sasken.com ([164.164.56.2]:54229 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S281440AbRKPOwF>;
	Fri, 16 Nov 2001 09:52:05 -0500
From: Sureshkumar Kamalanathan <skk@sasken.com>
Subject: dev_queue_xmit()
Date: Fri, 16 Nov 2001 20:21:59 +0530
Organization: Sasken Communication Technologies Limited
Message-ID: <3BF5280F.3ED0DD80@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Good day!
  I am making some changes to the ethernet header for all outgoing
packets.  I need to add a tag to it.  This tag will be recognised by the
target machine.
  Currently, I am putting this tag addition code in dev_queue_xmit(). 
It doesn't work.  When I do gdb (remote gdb), I found that
skb->mac.ethernet was 0.  What does it mean?
  Is the ethernet header removed by the calling functions of
dev_queue_xmit()?
  And, if I have to do changes to all outgoing ethernet packets, which
is the appropriate function?  Isn't dev_queue_xmit() the correct one?
  
  Thanks a lot in advance,

Regards,
Suresh.

-- 
Sureshkumar Kamalanathan,
Ph: 5578300 Extn: 8072.
Sasken Communication Technologies Limited, Bangalore.
(Formerly, Silicon Automation Systems.)
