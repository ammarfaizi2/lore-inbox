Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264923AbTFQUSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264926AbTFQUSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 16:18:00 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24025 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264923AbTFQUR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 16:17:59 -0400
Date: Tue, 17 Jun 2003 13:27:20 -0700 (PDT)
Message-Id: <20030617.132720.22019247.davem@redhat.com>
To: janiceg@us.ibm.com
Cc: jgarzik@pobox.com, shemminger@osdl.org, Valdis.Kletnieks@vt.edu,
       girouard@us.ibm.com, stekloff@us.ibm.com, lkessler@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEF78F4.2070604@us.ibm.com>
References: <3EEF7030.6030303@us.ibm.com>
	<20030617.125040.58438649.davem@redhat.com>
	<3EEF78F4.2070604@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice M Girouard <janiceg@us.ibm.com>
   Date: Tue, 17 Jun 2003 15:24:20 -0500
   
   Perhaps if RDMA is  capabilities are added to Linux, then things
   might be different.
   
   So.. when do you think RDMA will show up on Linx?

RDMA is total junk.

On RX, clever RX buffer management is what we need.

On TX zerocopy + TSO is more than sufficient and we have
that today.

