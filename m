Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbVCVDpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbVCVDpF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:45:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262354AbVCVDos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 22:44:48 -0500
Received: from fire.osdl.org ([65.172.181.4]:36027 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262353AbVCVDkz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 22:40:55 -0500
Date: Mon, 21 Mar 2005 19:40:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: buakaw@buakaw.homelinux.net
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: dst cache overflow
Message-Id: <20050321194022.491060c7.akpm@osdl.org>
In-Reply-To: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
References: <1144.192.168.0.37.1111351868.squirrel@buakaw.homelinux.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buakaw@buakaw.homelinux.net wrote:
>
> the system become very laggy.
> i use kernel 2.6.10/2.6.11.3 on p4 2.8, msi915p, 3 x 3com905 boomerang.
> and the cpu usage normally be about 12% and after something happens it
> boost to 100% and it is used mostly by ksoftirqd/0, and a little bit by 
> migration/0 and event/0. and in syslog i found thies lines
> 
> Mar 20 22:21:09 buakaw kernel: printk: 5543 messages suppressed.
> Mar 20 22:21:09 buakaw kernel: dst cache overflow
> 
> what can cause this?

Could you please describe the workload?  What is the computer doing at the
time, and how is it set up?

Thanks.
