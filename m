Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbVBZOSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbVBZOSC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 09:18:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVBZOSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 09:18:02 -0500
Received: from mail3.euroweb.net.mt ([217.145.4.38]:30360 "EHLO
	mail3.euroweb.net.mt") by vger.kernel.org with ESMTP
	id S261202AbVBZORg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 09:17:36 -0500
Message-ID: <42208509.3080201@euroweb.net.mt>
Date: Sat, 26 Feb 2005 15:17:45 +0100
From: "Josef E. Galea" <josefeg@euroweb.net.mt>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: System call problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am implemeting a new system call for a project I'm working on. I added 
the system call to the file arch/i386/kernel/process.c and added the 
relevant entries in the files arch/i386/entry.S and 
include/asm-i386/unistd.h. My system call is made up of only two lines, 
a printk statement, and a return statement which gets the value of a 
field that I added to the task_struct structure.

I compiled and booted the kernel and am trying to build a user space 
application that uses my system call, however gcc is returning this error:
/tmp/cc4zgzUr.o(.text+0x4e): In functiono `get_rmt_paging':
: undefined reference to `errno'

Can anyone help me with this?

Thanks
Josef
