Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVESPrh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVESPrh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 11:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262542AbVESPrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 11:47:37 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:59056 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262549AbVESPrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 11:47:33 -0400
Subject: Re: Why yield in coredump_wait? [was: Re: Resent: BUG in RT 45-01
	when RT program dumps core]
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linus Torvalds <torvalds@osdl.org>, kus Kusche Klaus <kus@keba.com>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1116509820.15866.28.camel@localhost.localdomain>
References: <AAD6DA242BC63C488511C611BD51F367323212@MAILIT.keba.co.at>
	 <1116503763.15866.9.camel@localhost.localdomain>
	 <1116509820.15866.28.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 19 May 2005 11:47:31 -0400
Message-Id: <1116517651.21685.50.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 09:37 -0400, Steven Rostedt wrote:
> Now if there were no other threads to wait on it would just continue.
> So, is there some real reason that this yield is there? Or is it just
> trying to be nice, as in saying, "I'm dieing now and just don't want to
> waste others time" (which I highly doubt is the case).

Why do you highly doubt this is the case?  This is actually the behavior
I would expect.

Lee

