Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbVDKQcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbVDKQcq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:32:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261833AbVDKQcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:32:46 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62710 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261831AbVDKQ3h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:29:37 -0400
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1112997093.12195.1.camel@mindpipe>
References: <1112991311.11000.37.camel@mindpipe>
	 <1112992701.26296.16.camel@dhcp153.mvista.com>
	 <1112997093.12195.1.camel@mindpipe>
Content-Type: text/plain
Organization: MontaVista
Message-Id: <1113236975.30548.9.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 11 Apr 2005 09:29:35 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 14:51, Lee Revell wrote:
> On Fri, 2005-04-08 at 13:38 -0700, Daniel Walker wrote:
> > I submitted a fix for this a while ago, I think ..
> > interruptible_sleep_on()'s are broken .. 
> 
> I saw the fix in -stable, but it does not seem to be in 2.6.12-rc2.


I didn't know it was in any of the kernels. Do I need to submit it to
Linus or something?

Daniel

