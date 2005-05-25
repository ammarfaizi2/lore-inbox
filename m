Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262384AbVEYSis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262384AbVEYSis (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 14:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVEYSdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 14:33:54 -0400
Received: from fire.osdl.org ([65.172.181.4]:16558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262392AbVEYScf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 14:32:35 -0400
Date: Wed, 25 May 2005 11:32:31 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: 2.6.12-rc5-tcp3
Message-ID: <20050525113231.4b5fef39@dxpl.pdx.osdl.net>
In-Reply-To: <20050524163939.0fb86509@dxpl.pdx.osdl.net>
References: <20050524163939.0fb86509@dxpl.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://developer.osdl.org/shemminger/patches/2.6.12-rc5-tcp3

Keep up with the new 2.6.12-rc5
More minor tweaks:
	- tcp_ack26 is already in rc5
	+ change to min_cwnd to be same (ie ssthresh/2) for all reno like protocols
	  eventually plan to fix the cwnd undershoot bug 
		http://thread.gmane.org/gmane.linux.network/2094 
		http://oss.sgi.com/projects/netdev/archive/2005-04/msg00338.html
