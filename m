Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272289AbRILVuE>; Wed, 12 Sep 2001 17:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270387AbRILVty>; Wed, 12 Sep 2001 17:49:54 -0400
Received: from cm038.32.234.24.lvcm.com ([24.234.32.38]:21634 "EHLO osafo.com")
	by vger.kernel.org with ESMTP id <S271820AbRILVtl>;
	Wed, 12 Sep 2001 17:49:41 -0400
Message-ID: <3B9FC13E.4040007@osafo.com>
Date: Wed, 12 Sep 2001 13:10:38 -0700
From: Colin Frank <kernel@osafo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Compining NetFilter: depmod, undefined symbols in 2.4.9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Has anyone compiled netfilter or used masquerading lately?
All of the iptables modules reference some missing symbol(s)

# depmod -a                   
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/ip_conntrack.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/ip_tables.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/ipchains.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/ipfwadm.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/ipt_REJECT.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/iptable_filter.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/iptable_mangle.o
depmod: *** Unresolved symbols in 
/lib/modules/2.4.9/kernel/net/ipv4/netfilter/iptable_nat.o
depmod: *** Unresolved symbols in /lib/modules/2.4.9/kernel/net/ipv6/ipv6.o

Colin...


