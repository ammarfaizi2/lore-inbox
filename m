Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWDGO2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWDGO2P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 10:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWDGO2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 10:28:15 -0400
Received: from zrtps0kp.nortel.com ([47.140.192.56]:9096 "EHLO
	zrtps0kp.nortel.com") by vger.kernel.org with ESMTP id S932240AbWDGO2P
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 10:28:15 -0400
Message-ID: <443676ED.10907@nortel.com>
Date: Fri, 07 Apr 2006 08:27:57 -0600
From: "Christopher Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Dike <jdike@addtoit.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: problem building UML kernel with 2.6.16.1 -- dies when linking
 vmlinux
References: <443580A4.1020806@nortel.com> <20060406215131.GA6422@ccure.user-mode-linux.org> <4435A0DA.1030606@nortel.com> <20060406234145.GA6893@ccure.user-mode-linux.org>
In-Reply-To: <20060406234145.GA6893@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2006 14:27:58.0989 (UTC) FILETIME=[781053D0:01C65A4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike wrote:
> On Thu, Apr 06, 2006 at 05:14:34PM -0600, Christopher Friesen wrote:
> 
>>Checking that ptrace can change system call numbers...OK
>>Checking syscall emulation patch for ptrace...missing
>>Checking PROT_EXEC mmap in /tmp...OK
>>UML running in TT mode
>>tracing thread pid = 8963
> 
> 
> Well, tt mode is deprecated in favor of skas0 these days, so you'll do
> better with CONFIG_MODE_SKAS enabled and CONFIG_MODE_TT disabled.

I just used CONFIG_MODE_TT based on the config comments for 
CONFIG_PT_PROXY: "If you want to do kernel debugging, say Y here; 
otherwise say N.".  This then required MODE_TT.

Can I run UML under gdb in skas mode?

Chris
