Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTD3KG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbTD3KG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:06:26 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:62602 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261823AbTD3KGZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:06:25 -0400
Date: Wed, 30 Apr 2003 12:18:39 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: must-fix list for 2.6.0
In-Reply-To: <87k7dcinxg.fsf@deneb.enyo.de>
Message-ID: <Pine.LNX.4.51.0304301216530.1728@dns.toxicfilms.tv>
References: <20030429231009$1e6b@gated-at.bofh.it> <87k7dcinxg.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > net/
> > ----
>
> What about the dst cache DoS attack?
What about IPv6 SYN attacks?
tcp_ipv6.c: static int tcp_v6_conn_request(...)
...
        /*
         *      There are no SYN attacks on IPv6, yet...
         */

Nmap is ip6 enabled and is getting its razor sharpened.

Regards,
Maciej

