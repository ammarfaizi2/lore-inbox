Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbUAVFis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 00:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbUAVFis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 00:38:48 -0500
Received: from mail-08.iinet.net.au ([203.59.3.40]:56552 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263679AbUAVFir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 00:38:47 -0500
Message-ID: <400F5D71.7010702@cyberone.com.au>
Date: Thu, 22 Jan 2004 16:19:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Andrew Morton <akpm@osdl.org>, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Directed migration: Don't Change cpumask in sched_balance_exec()
References: <20040122032941.3377D2C26B@lists.samba.org>
In-Reply-To: <20040122032941.3377D2C26B@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>Hi Nick,
>
>	This is against 2.6.2-rc1, but with some merging should work
>against -mm.  I think you'll like this approach.
>

Hi Rusty,
Yes I do like it. It hass bothered me that the visible cpus_allowed
mask is changed in order to do the balancing. Thanks Rusty. Ingo?


