Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUHOHPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUHOHPm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266519AbUHOHPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:15:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:35790 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266517AbUHOHPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:15:38 -0400
Date: Sun, 15 Aug 2004 00:14:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig.debug for 2.6.8
Message-Id: <20040815001402.0b9699d7.akpm@osdl.org>
In-Reply-To: <20040815071304.GA7182@mars.ravnborg.org>
References: <20040814110522.4879ddd4.rddunlap@osdl.org>
	<20040815071304.GA7182@mars.ravnborg.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Sat, Aug 14, 2004 at 11:05:22AM -0700, Randy.Dunlap wrote:
>  > 
>  > Here's the Kconfig.debug patch updated for 2.6.8:
>  > 
>  >   http://developer.osdl.org/rddunlap/kconfig/kconfig-debug-268.patch
> 
>  Hi Andrew.
> 
>  Any good way we can bring this patch forward?
>  Currently it causes 9 rejects in -mm, and I understand why you are not
>  inclined to fix that up.

Yeah, it's painful.  I'd be inclined to base it against -linus and then fix
up the individual -mm patches.  It's a matter of finding a suitable time
window in which to do that.   I'll take a shot at it tomorrow.
