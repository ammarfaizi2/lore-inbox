Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbVIMOnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbVIMOnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 10:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVIMOnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 10:43:15 -0400
Received: from mail.dvmed.net ([216.237.124.58]:17317 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964799AbVIMOnO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 10:43:14 -0400
Message-ID: <4326E576.1010204@pobox.com>
Date: Tue, 13 Sep 2005 10:43:02 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: TCP oopsing continues
References: <20050910113737.GZ22129@postel.suug.ch> <E1EE4Jh-0001iA-00@gondolin.me.apana.org.au> <20050910125010.GA22129@postel.suug.ch> <20050910194447.GA5725@gondor.apana.org.au> <20050910203131.GB22129@postel.suug.ch>
In-Reply-To: <20050910203131.GB22129@postel.suug.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, my oops continues in 2.6.14-rc1.  x86 SMP firewall box.

I still haven't found my null modem cable, so I don't have the top of 
the trace.  Here is everything that was on the screen:

ip_local_deliver_finish
tcp_v4_do_rcv
tcp_v4_rcv
ip_local_deliver
ip_local_deliver_finish
ip_rcv
ip_rcv_finish
netif_receive_skb
e1000_clean_rx_irq
rtl8139_isr_ack
e1000_clean
net_rx_action
__do_softirq
do_softirq
do_IRQ


