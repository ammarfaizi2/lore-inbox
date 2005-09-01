Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965186AbVIATm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965186AbVIATm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 15:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbVIATm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 15:42:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965186AbVIATm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 15:42:56 -0400
Date: Thu, 1 Sep 2005 12:41:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: viro@ZenIV.linux.org.uk, Matt_Domsch@Dell.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][CFLART] ipmi procfs bogosity
Message-Id: <20050901124114.7af633b1.akpm@osdl.org>
In-Reply-To: <1125592902.27283.5.camel@i2.minyard.local>
References: <20050901064313.GB26264@ZenIV.linux.org.uk>
	<1125592902.27283.5.camel@i2.minyard.local>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> Indeed, this function is badly written.  In rewriting, I couldn't find a
>  nice function for reading integers from userspace, and the proc_dointvec
>  stuff didn't seem terribly suitable.

We write numbers into profs files all the time.  Is there something
different about the IPMI requirement which makes the approach used by, say,
dirty_writeback_centisecs_handler() inappropriate?
