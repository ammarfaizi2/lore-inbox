Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSJAGKc>; Tue, 1 Oct 2002 02:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbSJAGKc>; Tue, 1 Oct 2002 02:10:32 -0400
Received: from [210.19.28.11] ([210.19.28.11]:4480 "EHLO
	dZuRa.int.Vault-ID.com") by vger.kernel.org with ESMTP
	id <S261494AbSJAGKb>; Tue, 1 Oct 2002 02:10:31 -0400
Date: Tue, 1 Oct 2002 14:25:28 +0800
From: Corporal Pisang <Corporal_Pisang@Counter-Strike.com.my>
To: linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netfilter-devel@lists.netfilter.org
Subject: 2.5.39 make modules_install error (netfilter)
Message-Id: <20021001142528.4640228c.Corporal_Pisang@Counter-Strike.com.my>
Organization: CS Malaysia
X-Mailer: Sylpheed version 0.8.3claws (GTK+ 1.2.10; )
User-Agent: Half Life (Build 1760)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Final hurdle for me to get 2.5.39 compiled, 

This is the error on make modules_install

if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.39; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.39/kernel/net/ipv4/netfilter/ipt_owner.o
depmod:         next_thread
depmod:         find_task_by_pid
depmod: *** Unresolved symbols in /lib/modules/2.5.39/kernel/net/ipv6/netfilter/ip6t_owner.o
depmod:         next_thread
depmod:         find_task_by_pid

Regards,

-Ubaida-
