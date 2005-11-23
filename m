Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbVKWTDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbVKWTDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKWTDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:03:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:54745 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932184AbVKWTC7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:02:59 -0500
Date: Wed, 23 Nov 2005 11:02:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 kswapd eating too much CPU
Message-Id: <20051123110241.528a0b37.akpm@osdl.org>
In-Reply-To: <20051123131417.GH24091@fi.muni.cz>
References: <20051122125959.GR16080@fi.muni.cz>
	<20051122163550.160e4395.akpm@osdl.org>
	<20051123010122.GA7573@fi.muni.cz>
	<4383D1CC.4050407@yahoo.com.au>
	<20051123051358.GB7573@fi.muni.cz>
	<20051123131417.GH24091@fi.muni.cz>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> wrote:
>
> 	I am at 2.6.15-rc2 now, the problem is still there.
>  Currently according to top(1), kswapd1 eats >98% CPU for 50 minutes now
>  and counting.

When it's doing this, could you do sysrq-p a few times?  The output of that
should tell us where the CPU is executing.
