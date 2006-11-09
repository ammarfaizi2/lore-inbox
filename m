Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754748AbWKIGl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754748AbWKIGl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 01:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754750AbWKIGl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 01:41:56 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1754748AbWKIGl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 01:41:56 -0500
Date: Wed, 8 Nov 2006 22:41:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Wendel <jwendel10@comcast.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5 breaks klogd 1.4.1
Message-Id: <20061108224153.4ed2e581.akpm@osdl.org>
In-Reply-To: <4552BB55.9090400@comcast.net>
References: <4552BB55.9090400@comcast.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2006 21:23:33 -0800
John Wendel <jwendel10@comcast.net> wrote:

> Just installed -rc5, system very slow, noticed klogd in a tight loop 
> doing a "read". -rc4 is OK.
> 
> Sorry, I have printk configured off, so I don't have any logs.
> 

Please run

	strace -p $(pidof klogd)

