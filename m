Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbVCLRTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbVCLRTP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 12:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVCLRTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 12:19:15 -0500
Received: from [62.206.217.67] ([62.206.217.67]:13734 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262014AbVCLRSK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 12:18:10 -0500
Message-ID: <42332451.9060802@trash.net>
Date: Sat, 12 Mar 2005 18:18:09 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.5) Gecko/20050106 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Kimmo Sundqvist <kimmo.sundqvist@mbnet.fi>
CC: linux-kernel@vger.kernel.org
Subject: Re: Badness in local_bh_enable at kernel/softirq.c:140
References: <200503121753.03974.kimmo.sundqvist@mbnet.fi>
In-Reply-To: <200503121753.03974.kimmo.sundqvist@mbnet.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kimmo Sundqvist wrote:
> Mar 12 10:39:45 shadowgate Badness in local_bh_enable at kernel/softirq.c:140
> Mar 12 10:39:45 shadowgate [<c0114ca4>] local_bh_enable+0x64/0x70
> Mar 12 10:39:45 shadowgate [<c486afd7>] isdn_ppp_xmit+0xf7/0x7e0 [isdn]
> Mar 12 10:39:45 shadowgate [<c485d646>] isdn_net_xmit+0x186/0x1d0 [isdn]
> Mar 12 10:39:45 shadowgate [<c485d9e7>] isdn_net_start_xmit+0x277/0x290 [isdn]

Herbert Xu fixed this in 2.6.11-rc3.

Regards
Patrick
