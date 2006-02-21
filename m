Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161375AbWBUFUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161375AbWBUFUw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 00:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161377AbWBUFUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 00:20:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35537 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161375AbWBUFUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 00:20:51 -0500
Date: Mon, 20 Feb 2006 21:19:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Hesse, Christian" <mail@earthworm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hald in status D with 2.6.16-rc4
Message-Id: <20060220211909.7964d56e.akpm@osdl.org>
In-Reply-To: <200602202034.29413.mail@earthworm.de>
References: <200602202034.29413.mail@earthworm.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Hesse, Christian" <mail@earthworm.de> wrote:
>
> Hello everybody,
> 
> since using kernel version 2.6.16-rc4 the hal daemon is in status D after 
> resume. I use suspend2 2.2.0.1 for 2.6.16-rc3. Any hints what could be the 
> problem? It worked perfectly with 2.6.15.x and suspend2 2.2.

a) Look in the logs for any oopses, other nasties

b) Do `echo t > /proc/sysrq-trigger', `dmesg -s 1000000 > foo' then find
   the trace for `hald' in `foo', send it to this list.

Thanks.
