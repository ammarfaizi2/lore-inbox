Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751030AbWDWEpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbWDWEpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 00:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWDWEpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 00:45:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4546 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751030AbWDWEpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 00:45:05 -0400
Date: Sat, 22 Apr 2006 21:43:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Al Boldi <a1426z@gawab.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [FIX] ide-io: increase timeout value to allow for slave wakeup
Message-Id: <20060422214356.0f8afbcb.akpm@osdl.org>
In-Reply-To: <200604230721.54550.a1426z@gawab.com>
References: <200604222359.21652.a1426z@gawab.com>
	<20060422145819.503c8451.akpm@osdl.org>
	<200604230721.54550.a1426z@gawab.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi <a1426z@gawab.com> wrote:
>
> Andrew Morton wrote:
> > Al Boldi <a1426z@gawab.com> wrote:
> > > During an STR resume cycle, the ide master disk times-out when there is
> > > also a slave present (especially CD).  Increasing the timeout in ide-io
> > > from 10,000 to 100,000 fixes this problem.
> > >
> > > Andrew, do I have to send a patch or can you take care of this
> > > one-liner?
> >
> > Please see the thread "sata suspend resume ..." on this mailing list,
> > starting Wed, 19 Apr.  It sounds like the same thing.
> 
> Yes, that's what prompted me to look into ide-io.
> So, will the sata fix also fix ide-io?
> 

Oh.  No.  Please send a patch.
