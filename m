Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbVGOTjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbVGOTjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVGOTjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:39:33 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:47590 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262016AbVGOTiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:38:06 -0400
Subject: Re: Kernel Bug Report
From: Lee Revell <rlrevell@joe-job.com>
To: linuxtwidler@gmail.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050715142405.0117dc21@localhost>
References: <20050715140411.28a30e55@localhost>
	 <1121455191.12420.40.camel@mindpipe>  <20050715142405.0117dc21@localhost>
Content-Type: text/plain
Date: Fri, 15 Jul 2005 15:38:11 -0400
Message-Id: <1121456292.12420.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-15 at 14:24 -0500, Lee wrote:
> Hi,
> 
> > > [20975.978911] PREEMPT SMP DEBUG_PAGEALLOC
> > > [20976.029194] Modules linked in: vmnet vmmon nvidia
> > > [20976.090907] CPU:    695757158
> > > [20976.090909] EIP:    0060:[<c0119ed8>]    Tainted: P      VLI
> >
> > Please reproduce the bug without these proprietary modules loaded.  And
> > make sure to include the stack trace.
> 
> My current setup has the kernel and metalog logging to the serial port, which I am monitoring using kermit rom another machine.
> 
> Would you mind explaining to me how to generate the strace track and/or how to do "proper" debugging when this crash occurs?

It should have been printed right after the output you posted.

Anyway, the first step is to reproduce it with a non tainted kernel.

Lee

