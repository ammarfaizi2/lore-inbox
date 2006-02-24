Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932605AbWBXWNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605AbWBXWNJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 17:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbWBXWNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 17:13:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932605AbWBXWNI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 17:13:08 -0500
Date: Fri, 24 Feb 2006 14:15:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: MIke Galbraith <efault@gmx.de>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, kernel@kolivas.org,
       pwil3058@bigpond.net.au, nickpiggin@yahoo.com.au,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch 2.6.16-rc4-mm1]  Task Throttling V14
Message-Id: <20060224141505.41b1a627.akpm@osdl.org>
In-Reply-To: <1140812981.8713.35.camel@homer>
References: <1140183903.14128.77.camel@homer>
	<1140812981.8713.35.camel@homer>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MIke Galbraith <efault@gmx.de> wrote:
>
> Not many comments came back, zero actually.
>

That's because everyone's terribly busy chasing down those final bugs so we
get a really great 2.6.16 release (heh, I kill me).

I'm a bit reluctant to add changes like this until we get the smpnice stuff
settled down and validated.  I guess that means once Ken's run all his
performance tests across it.

Of course, if Ken does his testing with just mainline+smpnice then any
coupling becomes less of a problem.  But I would like to see some feedback
from the other sched developers first.
