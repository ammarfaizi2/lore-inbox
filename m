Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261625AbTDOOu5 (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 10:50:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTDOOu5 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 10:50:57 -0400
Received: from watch.techsource.com ([209.208.48.130]:33741 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261625AbTDOOu4 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 10:50:56 -0400
Message-ID: <3E9C226E.6090102@techsource.com>
Date: Tue, 15 Apr 2003 11:17:02 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Quick way to get preprocessor output???
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is in regard to the kernel message compression I'm working on.

I'm starting work on the code parser for the kernel, and I find that a 
lot of the printk format strings have macros in them.  Is there a quick 
and easy way to get preprocessor (.i) output from all kernel source files?

I'm sure I won't understand enough to hack all Makefiles, but in case I 
have to, what would be the best way of going about it?  I know about 
using -E, but I don't want to take an excessive amount of time on this.

Of course, to actually implement the text compression, all Makefiles 
will have to change anyhow to pipe preprocessor output through a program 
whose output is then run through the compiler.


