Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDJEWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 00:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUDJEWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 00:22:47 -0400
Received: from fw.osdl.org ([65.172.181.6]:34007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261907AbUDJEWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 00:22:44 -0400
Date: Fri, 9 Apr 2004 21:22:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, chrisw@osdl.org,
       luto@myrealbox.com
Subject: Re: [PATCH, local root on 2.4, 2.6?] compute_creds race (fixed
 patch)
Message-Id: <20040409212232.261ba0d6.akpm@osdl.org>
In-Reply-To: <40772FED.6060905@myrealbox.com>
References: <fa.fuv6lk6.1444ua6@ifi.uio.no>
	<40772FED.6060905@myrealbox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> wrote:
>
> User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)

uh-oh.

>  My previous patch broke LSM.  Here's a fixed version,

patching file fs/exec.c
Hunk #1 FAILED at 869.
Hunk #2 FAILED at 935.
2 out of 2 hunks FAILED -- saving rejects to file fs/exec.c.rej
patching file security/selinux/hooks.c
Hunk #1 FAILED at 1746.
Hunk #2 succeeded at 1755 with fuzz 2 (offset -1 lines).
Hunk #3 FAILED at 2560.
Hunk #4 FAILED at 3971.
3 out of 4 hunks FAILED -- saving rejects to file security/selinux/hooks.c.rej
patching file security/commoncap.c
Hunk #1 FAILED at 115.
Hunk #2 FAILED at 134.
Hunk #3 FAILED at 325.
Hunk #4 FAILED at 387.
4 out of 4 hunks FAILED -- saving rejects to file security/commoncap.c.rej
patching file security/dummy.c
Hunk #1 FAILED at 26.
Hunk #2 FAILED at 118.
Hunk #3 FAILED at 171.
Hunk #4 FAILED at 910.
4 out of 4 hunks FAILED -- saving rejects to file security/dummy.c.rej
patching file security/capability.c
Hunk #1 FAILED at 35.
1 out of 1 hunk FAILED -- saving rejects to file security/capability.c.rej
patching file include/linux/security.h
patch: **** malformed patch at line 289: *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);


Please resend as an attachment.  These fancypants mailers just can't keep
their sticky paws off plain text.

