Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUHJTVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUHJTVS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 15:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267571AbUHJTVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 15:21:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21663 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267687AbUHJTU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 15:20:59 -0400
Subject: Re: bkl cleanup in do_sysctl
From: Lee Revell <rlrevell@joe-job.com>
To: Roland Dreier <roland@topspin.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Josh Aas <josha@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
In-Reply-To: <52n0126byf.fsf@topspin.com>
References: <4118FE9D.2050304@sgi.com> <1092158905.11212.18.camel@nighthawk>
	 <1092163919.782.54.camel@mindpipe>  <52n0126byf.fsf@topspin.com>
Content-Type: text/plain
Message-Id: <1092165679.920.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 15:21:19 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 15:16, Roland Dreier wrote:
>     Lee> For example reiserfs uses the BKL for all write locking (!),
>     Lee> but it probably would not be too hard to fix, because you can
>     Lee> just look at another filesystem that has proper locking.
> 
> Fixing up a filesystem's write locking doesn't sound like a very good
> newbie project to me.
> 

Exactly, the point isn't to get them to fix it, but as a way to learn
the internals of Linux, with the side benefit that someone might propose
a correct fix.  Also, many people might be new to Linux kernel hacking
but are knowledgeable re: operating systems.  Just a thought.

Lee

