Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWHHHkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWHHHkR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 03:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932530AbWHHHkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 03:40:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932528AbWHHHkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 03:40:16 -0400
Date: Tue, 8 Aug 2006 00:40:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       NetDev <netdev@vger.kernel.org>
Subject: Re: 2.6.18-rc3-mm2: bad e1000 device name
Message-Id: <20060808004011.ab3cd65f.akpm@osdl.org>
In-Reply-To: <44D78A48.7050707@goop.org>
References: <44D78A48.7050707@goop.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 11:45:28 -0700
Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> With 2.6.18-rc3-mm2, I get a bogus device name for my e1000 device, 
> which I would expect to be eth0:
> 
> : ezr:pts/0; ifconfig -a
> �6f�      Link encap:Ethernet  HWaddr 00:16:D3:20:D2:0B  
>           UP BROADCAST MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000 
>           RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
>           Base address:0x2000 Memory:ee000000-ee020000 
> [...]

e1000 seems OK here.  Don't know, sorry.
