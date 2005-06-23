Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263066AbVFWUQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263066AbVFWUQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 16:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbVFWUQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 16:16:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:19632
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262947AbVFWUQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 16:16:05 -0400
Date: Thu, 23 Jun 2005 13:15:41 -0700 (PDT)
Message-Id: <20050623.131541.71084496.davem@davemloft.net>
To: kiragon@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.12 Ethernet bridge over bonding interfaces
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <d4cc500a05062304344ebb57d7@mail.gmail.com>
References: <200506230742.49926.kiragon@gmail.com>
	<d4cc500a05062304344ebb57d7@mail.gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Garik E <kiragon@gmail.com>
Date: Thu, 23 Jun 2005 14:34:59 +0300

> Ethernet bridge configured over bonding interfaces dead loops and
> multiplies ethernet broadcast packets (ARP requests)
> The following patch solves this problem.
> 
> Signed-off-by: Garik E. <kiragon@gmail.com>

1) Your email client mangled the TAB characters and spacing
   in the patch.

2) Networking patches should be sent to netdev@vger.kernel.org
   and usually with the maintainer of the code you're touching
   CC:'d.  In this case it would be (from linux/MAINTAINERS):

	BONDING DRIVER
	P:   Chad Tindel
	M:   ctindel@users.sourceforge.net
	P:   Jay Vosburgh
	M:   fubar@us.ibm.com
	L:   bonding-devel@lists.sourceforge.net
	W:   http://sourceforge.net/projects/bonding/
	S:   Supported

Thanks.
