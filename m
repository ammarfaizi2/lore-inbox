Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263988AbTJFHUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 03:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTJFHUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 03:20:43 -0400
Received: from 209.220.4.150.ptr.us.xo.net ([209.220.4.150]:61346 "EHLO
	versant.com") by vger.kernel.org with ESMTP id S263988AbTJFHUm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 03:20:42 -0400
Date: Mon, 6 Oct 2003 12:52:00 +0530 (IST)
From: Tushar Telichari <tushar@versant.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Shared memory problem
Message-ID: <Pine.LNX.4.21.0310061244540.20274-100000@dahlia.vipl.versant.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a process which requires about 1G of shared memory.
There are multiple processes which are going to share this.
I am able to allocate this by setting shmmax..etc. 
This works fine if this is the only process running.
The problem is, I am not aware that during production if the arena
which I am going to allocate just  might be used by some other process.
Please let me know if there is method to handle this issue and a method
to check for the memory map at runtime.

Regards,

-- 
Tushar Telichari
Email: tushar@versant.com
Websites: http://www.versant.com http://www.geocities.com/t_telichari


