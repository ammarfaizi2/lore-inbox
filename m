Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTKSVh5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTKSVh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:37:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:51127 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264151AbTKSVhz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:37:55 -0500
Date: Wed, 19 Nov 2003 13:38:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9-mm4 (only) and vmware
Message-Id: <20031119133814.39dbd3b7.akpm@osdl.org>
In-Reply-To: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
References: <20031119181518.0a43c673.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar> wrote:
>
> With the recent 2.6.0-test9-mm4 i can't start the vmware, it reports in vmware.log (debug ON):
> 
> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical memory: req=49152 avail=0 over
> head=4096 maxRespage=106496
> Nov 19 17:27:40: vmx| WSSCAN: Not enough physical (in MB): nbVM=3 hostMem=512 ch
> eckMemory=1
> 
> With linus tree from 2.6.0-test9-mm4/broken-out/linus.patch and 2.6.0-test3-mm3 don't have problem.

hm, that's funny.

> Any other test from broken-out to patch it?

I can't immediately think what could have caused that.  Maybe if you were
to strace vmware startup, see what is failing?
