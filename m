Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269152AbUI2WLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269152AbUI2WLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 18:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUI2WLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 18:11:43 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:4305 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269079AbUI2WL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 18:11:27 -0400
Message-ID: <415B330A.6080207@nortelnetworks.com>
Date: Wed, 29 Sep 2004 16:11:22 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: looking for cond_syscall usage instructions
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm adding some syscalls to the kernel based on config options.  I just came 
across cond_syscall, and it looks useful, but there are no instructions I've 
seen on exactly how to use it.

Do I just add another line to kernel/sys.c with my syscall and then wrap the 
whole syscall source with an #ifdef?

Chris
