Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbUBUDIp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUBUDIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:08:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:37509 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261490AbUBUDIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:08:44 -0500
Date: Fri, 20 Feb 2004 19:08:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ron Peterson <rpeterso@MtHolyoke.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
Message-Id: <20040220190859.67442592.akpm@osdl.org>
In-Reply-To: <Pine.OSF.4.21.0402202128320.394202-100000@mhc.mtholyoke.edu>
References: <Pine.OSF.4.21.0402202128320.394202-100000@mhc.mtholyoke.edu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Peterson <rpeterso@MtHolyoke.edu> wrote:
>
>  http://depot.mtholyoke.edu:8080/tmp/

Could you chmod user.log and vmstat.log for us?

There are a few things you should try - you probably already have:

- Stop all applications, restart them

- Unload net driver module, reload and reconfigure it.

If either of those (or similar operations) are found to bring the latency
back to normal then that would be a big hint.  ie: we need to find
something which brings the performance back apart from a complete reboot.

Also, look out for consistent increases in either urer or system CPU time.

