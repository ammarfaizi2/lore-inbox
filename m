Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261166AbUKETMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUKETMa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 14:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261167AbUKETM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 14:12:29 -0500
Received: from webmail.cs.unm.edu ([64.106.20.39]:2007 "EHLO mail.cs.unm.edu")
	by vger.kernel.org with ESMTP id S261166AbUKETM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 14:12:26 -0500
Message-ID: <418BD090.1020702@cs.unm.edu>
Date: Fri, 05 Nov 2004 12:12:16 -0700
From: Sushant Sharma <sushant@cs.unm.edu>
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: system calls in 2.6.3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan *1CQ9VQ-0008F5-00*gZAHFGzQOGc*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
I have added a system call to the kernel 2.6.3.
Can someone tell me, if I have to recompile gcc or glibc inorder to
use that system call from user space. Right now its required
to do
#define __NR_syscallname 274 /*(syscall number)*/
static inline _syscall1(.....); /*stub*/

inside my own header file from user space.

Will recompiling gcc or glibc will update header files
in /usr/include directory so that I dont need to include
above statements in my header file?

Thanks
Sushant

ps: pleace cc the reply to me as I am not subscribed to the list


<Sushant Sharma At cs dot unm dot edu>
http://cs.unm.edu/~sushant/

