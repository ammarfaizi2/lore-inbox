Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262483AbVCVFgt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262483AbVCVFgt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbVCVFeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:34:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20203 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262387AbVCVFa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:30:56 -0500
Subject: Re: kernel bug: futex_wait hang
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Chris Morgan <cmorgan@alum.wpi.edu>,
       paul@linuxaudiosystems.com, seto.hidetoshi@jp.fujitsu.com
In-Reply-To: <20050321210802.14be70cc.akpm@osdl.org>
References: <1111463950.3058.20.camel@mindpipe>
	 <20050321202051.2796660e.akpm@osdl.org>
	 <20050322044838.GB32432@mail.shareable.org>
	 <20050321210802.14be70cc.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Mar 2005 00:30:53 -0500
Message-Id: <1111469453.3563.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-21 at 21:08 -0800, Andrew Morton wrote:
> Jamie Lokier <jamie@shareable.org> wrote:
> > 
> > The most recent messages under "Futex queue_me/get_user ordering",
> > with a patch from Jakub Jelinek will fix this problem by changing the
> > kernel.  Yes, you should apply Jakub's most recent patch, message-ID
> > "<20050318165326.GB32746@devserv.devel.redhat.com>".
> > 
> > I have not tested the patch, but it looks convincing.
> 
> OK, thanks.  Lee && Paul, that's at
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.6.12-rc1-mm1/broken-out/futex-queue_me-get_user-ordering-fix.patch
> 

Does not fix the problem.

Lee

