Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUHZQjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUHZQjp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269145AbUHZQjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:39:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:56753 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269179AbUHZQjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:39:15 -0400
Date: Thu, 26 Aug 2004 09:28:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Arne Henrichsen <ahenric@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sys_sem* undefined
Message-Id: <20040826092825.0fc2eeb9.rddunlap@osdl.org>
In-Reply-To: <20040826134403.34510.qmail@web41507.mail.yahoo.com>
References: <20040825091413.0c43c78d.rddunlap@osdl.org>
	<20040826134403.34510.qmail@web41507.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 14:44:03 +0100 (BST) Arne Henrichsen wrote:

| Hi,
| 
| I realise now that one obviously calls these functions
| via system calls. Ok, I have never done that before in
| Linux. This is probably not the correct group to ask
| this, but where is there a good place to start? Maybe
| with a simple example on how to do system calls in
| Linux?

>From an application (userspace) or from inside the kernel?

There are many "howto add a system call to Linux" web pages
out there (use google).  Oh, you want "howto do a system call."

>From userspace, usually use a library:  app calls library
function, which does the syscall.  Or you can roll your
own syscalls.  The howtos on adding a system call to Linux
usually show you how to do that part also.[1]

--
~Randy

[1] written for 2.4.18:
http://www.xenotime.net/linux/syscall_ex/howto_adda_syscall.txt
