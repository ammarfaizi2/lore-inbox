Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbVI1GuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbVI1GuW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 02:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVI1GuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 02:50:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751058AbVI1GuV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 02:50:21 -0400
Date: Tue, 27 Sep 2005 23:49:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setting PF_ flags from user space PF_LESS_THROTTLE
Message-Id: <20050927234929.0ea86128.akpm@osdl.org>
In-Reply-To: <1127858515.6120.3.camel@stevef95.austin.ibm.com>
References: <1127858515.6120.3.camel@stevef95.austin.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French <smfltc@us.ibm.com> wrote:
>
> I wanted to see if PF_LESS_THROTTLE would be helpful for Samba to set(as
> it is for nfsd, which sets it directly in kernel) to avoid loopback
> mount hangs when low on memory.
> 
> Any idea whether the task flags, in particular PF_LESS_THROTTLE could be
> set from user space (I did not see an obvious way, short of invoking a
> new kernel helper, which does not exist, to set it on user space's
> behalf)?

sys_prctl()?
