Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVCXURp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVCXURp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVCXURp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:17:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:53959 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261957AbVCXURn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:17:43 -0500
Date: Thu, 24 Mar 2005 12:17:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc1-mm2
Message-Id: <20050324121722.759610f4.akpm@osdl.org>
In-Reply-To: <1111682812.23440.6.camel@mindpipe>
References: <20050324044114.5aa5b166.akpm@osdl.org>
	<1111682812.23440.6.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> On Thu, 2005-03-24 at 04:41 -0800, Andrew Morton wrote:
> >   -mm kernels now aggregate Linus's tree and 34 subsystem trees.  Usually
> >   they are pulled 3-4 hours before the release of the -mm kernel.  
> > 
> 
> Andrew,
> 
> Do you notify the subsystem maintainers ahead of time so that critical
> fixes can be pushed to BK?

Occasionally I'll go out and ping people, but almost always the subsystem
guys know what the development cycle is, and they appropriately decide
which code should go in, and when.

> I am thinking of the recent ALSA example, where the emu10k1 driver was
> b0rked in 2.6.12-mm1, but the fix had been in ALSA CVS for a week.
> 

We've been discussing how to get ALSA CVS into ALSA bk more promptly.
