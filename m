Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVL0SD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVL0SD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 13:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932373AbVL0SD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 13:03:59 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:28583 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932365AbVL0SD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 13:03:58 -0500
Date: Tue, 27 Dec 2005 19:03:49 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Mikado <mikado4vn@yahoo.com>, linux-kernel@vger.kernel.org,
       linux-c-programming@vger.kernel.org
Subject: Re: How to obtain process ID that created a packet
In-Reply-To: <43B11D9C.6000601@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0512271903180.3068@yvahk01.tjqt.qr>
References: <20051227014710.43609.qmail@web53708.mail.yahoo.com>
 <Pine.LNX.4.61.0512270925020.10069@yvahk01.tjqt.qr> <43B11D9C.6000601@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>In current 2.6 kernel, net/ipv4/netfilter/ipt_owner.c:checkentry() :
>
>        if (info->match & (IPT_OWNER_PID|IPT_OWNER_SID|IPT_OWNER_COMM)) {
>                printk("ipt_owner: pid, sid and command matching "
>                       "not supported anymore\n");
>                return 0;
>        }
>
>So... even netfilter, breaking backward compatibility, does not support
>pid match anymore...

Because they do not work on SMP. That's the reason they are disabled.



Jan Engelhardt
-- 
| Alphagate Systems, http://alphagate.hopto.org/
| jengelh's site, http://jengelh.hopto.org/
