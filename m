Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbTE0Xnr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbTE0Xnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:43:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15512 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264450AbTE0Xnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:43:47 -0400
Date: Tue, 27 May 2003 16:55:05 -0700 (PDT)
Message-Id: <20030527.165505.38711831.davem@redhat.com>
To: andrea@suse.de
Cc: akpm@digeo.com, davidsen@tmr.com, haveblue@us.ibm.com, habanero@us.ibm.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: userspace irq balancer
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030527222712.GB1453@dualathlon.random>
References: <20030527115314.GU3767@dualathlon.random>
	<20030527.150449.08322270.davem@redhat.com>
	<20030527222712.GB1453@dualathlon.random>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Wed, 28 May 2003 00:27:12 +0200

   On Tue, May 27, 2003 at 03:04:49PM -0700, David S. Miller wrote:
   > The problem is that is gives up and goes to ksoftirqd far too easily.
   
   I see your point, please try with 2.4.21rc4aa1 or with this patch:

Thanks Andrea, I will go from theorist to real scientist over
the next few days and try to come up with some real experimental
evidence of how all of this behaves.

Thanks.
