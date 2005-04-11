Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261854AbVDKQnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261854AbVDKQnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDKQkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:40:09 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30699 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261839AbVDKQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:37:23 -0400
Subject: Re: 'BUG: scheduling with irqs disabled' when umounting NFS volume
From: Lee Revell <rlrevell@joe-job.com>
To: dwalker@mvista.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
In-Reply-To: <1113236975.30548.9.camel@dhcp153.mvista.com>
References: <1112991311.11000.37.camel@mindpipe>
	 <1112992701.26296.16.camel@dhcp153.mvista.com>
	 <1112997093.12195.1.camel@mindpipe>
	 <1113236975.30548.9.camel@dhcp153.mvista.com>
Content-Type: text/plain
Date: Mon, 11 Apr 2005 12:37:22 -0400
Message-Id: <1113237442.29578.2.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-11 at 09:29 -0700, Daniel Walker wrote:
> On Fri, 2005-04-08 at 14:51, Lee Revell wrote:
> > On Fri, 2005-04-08 at 13:38 -0700, Daniel Walker wrote:
> > > I submitted a fix for this a while ago, I think ..
> > > interruptible_sleep_on()'s are broken .. 
> > 
> > I saw the fix in -stable, but it does not seem to be in 2.6.12-rc2.
> 
> 
> I didn't know it was in any of the kernels. Do I need to submit it to
> Linus or something?

I must be thinking of a different bug then.  Anyway, Ingo said this was
fixed in the latest RT kernels.

Lee

