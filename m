Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288991AbSAFQ6l>; Sun, 6 Jan 2002 11:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288990AbSAFQ6a>; Sun, 6 Jan 2002 11:58:30 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:11014 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S286303AbSAFQ6S>;
	Sun, 6 Jan 2002 11:58:18 -0500
Mailbox-Line: From tmh@nothing-on.tv  Sun Jan  6 16:57:13 2002
Mailbox-Line: From tmh@nothing-on.tv  Sun Jan  6 16:57:05 2002
From: Tony Hoyle <tmh@nothing-on.tv>
Subject: CONFIG_HIMEM instability?
Date: Sun, 06 Jan 2002 16:57:17 +0000
Organization: cvsnt.org news server
Message-ID: <3C3881ED.5060303@nothing-on.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: sisko.my.home 1010336224 6115 192.168.2.3 (6 Jan 2002 16:57:04 GMT)
X-Complaints-To: abuse@cvsnt.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011229
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my machine to 1GB so I had to switch on the 
CONFIG_HIGHMEM setting.  Ever since although the kernel has been OK 
userspace apps have started dropping out for no apparent reason 
(gkrellm, for example, crashes about every 10 minutes).

What does CONFIG_HIGHMEM actually modify that could affect userspace?  I 
was under the impression it just moved the kernel structures higher up 
in the memory space.

Unfortunately memtest86 is incompatible with this mobo, but the memory 
checks out on another machine I tried it on, so I expect it's OK.

Tony

-- 
"Wipe Info uses hexadecimal values to wipe files. This provides more 
security than wiping with decimal values." -- Norton SystemWorks 2002 Manual

tmh@nothing-on.tv 
http://www.nothing-on.tv

