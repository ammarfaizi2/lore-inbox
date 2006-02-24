Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWBXUcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWBXUcg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 15:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbWBXUcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 15:32:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47050 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751017AbWBXUcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 15:32:35 -0500
Date: Fri, 24 Feb 2006 12:31:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Gautam H Thaker <gthaker@atl.lmco.com>
Cc: mingo@elte.hu, gautam.h.thaker@lmco.com, linux-kernel@vger.kernel.org
Subject: Re: ~5x greater CPU load for a networked application when using
 2.6.15-rt15-smp vs. 2.6.12-1.1390_FC4
Message-Id: <20060224123129.4ec024d4.akpm@osdl.org>
In-Reply-To: <43FF675A.6080305@atl.lmco.com>
References: <43FE134C.6070600@atl.lmco.com>
	<20060223205851.GA24321@elte.hu>
	<20060224041145.5bcdbc97.akpm@osdl.org>
	<43FF675A.6080305@atl.lmco.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gautam H Thaker <gthaker@atl.lmco.com> wrote:
>
> > http://www.zip.com.au/~akpm/linux/#zc  <- better ;)
> 
>  Andrew,
> 
>  I read the README for the "zc" tests. I wish Ingo can opine on which may be a
>  better test. Also, i assume that I can run "zcs" and "zcc" on the same
>  machine. I would do the tests with "send" instead of "sendfile".

Oh.  I don't actually remember what zc does.  I was actually referring to
`cyclesoak', which has proven to be a pretty accurate (or at least,
sensitive and repeatable) way of determining overall per-CPU system load.
