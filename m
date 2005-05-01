Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVEAWMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVEAWMr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 18:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVEAWKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 18:10:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:37577 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262691AbVEAWHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 18:07:05 -0400
Date: Sun, 1 May 2005 15:06:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Damir Perisa <damir.perisa@solnet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc3-mm2 - kswapd0 keeps running
Message-Id: <20050501150624.7696fc31.akpm@osdl.org>
In-Reply-To: <200505011707.35461.damir.perisa@solnet.ch>
References: <20050430164303.6538f47c.akpm@osdl.org>
	<200505011707.35461.damir.perisa@solnet.ch>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Damir Perisa <damir.perisa@solnet.ch> wrote:
>
> i updated from rc2-mm3 to rc3-mm2 and now i observe something strange: 
>  the cpu is running all the time at 100% because of the kswapd0 that is 
>  running always and not becomming idle. 
> 
>  after having the computer running for about one hour, top says this about 
>  kswapd0:
> 
>    PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
>    155 root      25   0     0    0    0 R 89.6  0.0  38:56.06 kswapd0

Could you type sysrq-P a few times, see if we can work out where it's stuck?

Thanks.
