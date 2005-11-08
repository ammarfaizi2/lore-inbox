Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965193AbVKHDSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965193AbVKHDSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 22:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbVKHDSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 22:18:51 -0500
Received: from xenotime.net ([66.160.160.81]:47745 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965160AbVKHDSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 22:18:50 -0500
Date: Mon, 7 Nov 2005 19:03:40 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
Subject: [OT] Re: [PATCH 3/18] allow callers of seq_open do allocation
 themselves
Message-Id: <20051107190340.129bc8c3.rdunlap@xenotime.net>
In-Reply-To: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk>
References: <E1EZInj-0001Eh-9T@ZenIV.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 08 Nov 2005 02:01:31 +0000 Al Viro wrote:

> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: 1131401734 -0500

What format is that date in, please?

> Allows caller of seq_open() to kmalloc() seq_file + whatever else they want
> and set ->private_data to it.  seq_open() will then abstain from doing
> allocation itself.
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---
~Randy
