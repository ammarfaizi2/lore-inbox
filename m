Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751235AbWDVV7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbWDVV7b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWDVV7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:59:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17899 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751235AbWDVV7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:59:30 -0400
Date: Sat, 22 Apr 2006 14:58:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [FIX] ide-io: increase timeout value to allow for slave wakeup
Message-Id: <20060422145819.503c8451.akpm@osdl.org>
In-Reply-To: <200604222359.21652.a1426z@gawab.com>
References: <200604222359.21652.a1426z@gawab.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
>
> 
> During an STR resume cycle, the ide master disk times-out when there is also 
> a slave present (especially CD).  Increasing the timeout in ide-io from 
> 10,000 to 100,000 fixes this problem.
> 
> Andrew, do I have to send a patch or can you take care of this one-liner?
> 

Please see the thread "sata suspend resume ..." on this mailing list,
starting Wed, 19 Apr.  It sounds like the same thing.
