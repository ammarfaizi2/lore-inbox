Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261618AbVDEIFJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbVDEIFJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbVDEH7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:46011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbVDEHpa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:45:30 -0400
Date: Tue, 5 Apr 2005 00:45:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-Id: <20050405004519.4be75785.akpm@osdl.org>
In-Reply-To: <425240C5.1050706@ens-lyon.org>
References: <20050405000524.592fc125.akpm@osdl.org>
	<425240C5.1050706@ens-lyon.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin <Brice.Goglin@ens-lyon.org> wrote:
>
> Andrew Morton a écrit :
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/
> 
>  Hi Andrew,
> 
>  printk timing seems broken.
>  It always shows [ 0.000000] on my Compaq Evo N600c.

What sort of CPU does that thing have?  Please share the /proc/cpuinfo
output.

Does reverting
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm1/broken-out/sched-x86-sched_clock-to-use-tsc-on-config_hpet-or-config_numa-systems.patch
fix it?

Thanks.
