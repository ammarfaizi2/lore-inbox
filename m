Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262906AbUERKby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUERKby (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 06:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbUERKbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 06:31:53 -0400
Received: from web90109.mail.scd.yahoo.com ([66.218.94.80]:49284 "HELO
	web90109.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S262906AbUERKbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 06:31:52 -0400
Message-ID: <20040518062857.80216.qmail@web90109.mail.scd.yahoo.com>
Date: Mon, 17 May 2004 23:28:57 -0700 (PDT)
From: linux lover <linux_lover2004@yahoo.com>
Subject: tracing calls of output(skb)
To: linuxkernel <linux-kernel@vger.kernel.org>
Cc: netdev <netdev@oss.sgi.com>,
       netfilter <netfilter-devel@lists.netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello friends,
          can anybody knows where does this
skb->dst->output(skb) call goes? it is written in
output_maybe_reroute function call in ip_output.c?
also let me know whether following two calls also
point to same destination funcaion as above function?
   hh->hh_output(skb);
   return dst->neighbour->output(skb);
if yes to which function they point (dev_queue_xmit)?

Thanking you.
linux_lover





	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
