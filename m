Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264190AbTDJVaI (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264191AbTDJVaI (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:30:08 -0400
Received: from web40601.mail.yahoo.com ([66.218.78.138]:37476 "HELO
	web40601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264190AbTDJVaF (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 17:30:05 -0400
Message-ID: <20030410214141.67857.qmail@web40601.mail.yahoo.com>
Date: Thu, 10 Apr 2003 14:41:41 -0700 (PDT)
From: Ranga Iyengar <ambuga@yahoo.com>
Subject: siginfo of traced child to parent process
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wanted to know if there is a way to get the
siginfo_t of a child process from a parent process.
The child process is traced by the parent process
using ptrace system call and if the child is stopped
because of SIGSEGV or SIGFPE, the address of the
instruction that caused the exception is available to
the child from the signal handler thro' the siginfo
structure. Is there any way of getting this
info(siginfo) to the parent. The parent attaches to
the child in the same way 'gdb' attaches to the
debugged programs.

I'm using linux kernel 2.4.18

Thanks
Ron

__________________________________________________
Do you Yahoo!?
Yahoo! Tax Center - File online, calculators, forms, and more
http://tax.yahoo.com
