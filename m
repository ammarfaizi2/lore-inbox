Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTKTBlW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 20:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263998AbTKTBlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 20:41:22 -0500
Received: from c-24-6-236-77.client.comcast.net ([24.6.236.77]:37848 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262714AbTKTBlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 20:41:22 -0500
Date: Wed, 19 Nov 2003 17:34:25 -0500
From: Christopher Li <lkml@chrisli.org>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-ID: <20031119223425.GA20549@64m.dyndns.org>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 06:15:18PM -0300, Gerardo Exequiel Pozzi wrote:
> Hi Andrew,
> 
> With the recent 2.6.0-test9-mm4 i can't start the vmware, it reports in vmware.log (debug ON):
> 
> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical memory: req=49152 avail=0 over
> head=4096 maxRespage=106496
> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical (in MB): nbVM=3 hostMem=512 ch
> eckMemory=1

Can you send me a few more lines of the log file before and after that message? I can take
a look at what is going on there. Most likely vmmon driver get confused.

> 
> With linus tree from 2.6.0-test9-mm4/broken-out/linus.patch and 2.6.0-test3-mm3 don't have problem.
> 

Chris
