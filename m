Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262036AbVANRn2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbVANRn2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 12:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbVANRn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 12:43:27 -0500
Received: from [62.206.217.67] ([62.206.217.67]:12991 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262036AbVANRnW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 12:43:22 -0500
Message-ID: <41E804A4.9040003@trash.net>
Date: Fri, 14 Jan 2005 18:43:00 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, coreteam@netfilter.org,
       netdev@oss.sgi.com
Subject: Re: [patch] 2.6.11-rc1-mm1: ip_tables.c: ipt_find_target must be
 EXPORT_SYMBOL'ed
References: <20050114002352.5a038710.akpm@osdl.org> <20050114173538.GB4274@stusta.de>
In-Reply-To: <20050114173538.GB4274@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Fri, Jan 14, 2005 at 12:23:52AM -0800, Andrew Morton wrote:
>
>>...
>>All 434 patches:
>>...
>>restore-net-sched-iptc-after-iptables-kmod-cleanup.patch
>>  Restore net/sched/ipt.c After iptables Kmod Cleanup
>>...
>>
>
>This causes the following error with CONFIG_NET_ACT_IPT=m:
>
><--  snip  -->
>
>if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.6.11-rc1-mm1; fi
>WARNING: /lib/modules/2.6.11-rc1-mm1/kernel/net/sched/ipt.ko needs unknown symbol ipt_find_target
>
><--  snip  -->
>
The fix is already in Dave's tree.

Regards
Patrick

