Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267697AbUHJUJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267697AbUHJUJy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 16:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267699AbUHJUJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 16:09:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:61094 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267697AbUHJUJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 16:09:48 -0400
Subject: Re: bkl cleanup in do_sysctl
From: Lee Revell <rlrevell@joe-job.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Josh Aas <josha@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       steiner@sgi.com
In-Reply-To: <411925FA.2000303@namesys.com>
References: <4118FE9D.2050304@sgi.com> <1092158905.11212.18.camel@nighthawk>
	 <1092163919.782.54.camel@mindpipe>  <411925FA.2000303@namesys.com>
Content-Type: text/plain
Message-Id: <1092168602.920.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 16:10:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 15:46, Hans Reiser wrote:
> Lee Revell wrote:
> >For example reiserfs uses the BKL for all write locking (!), but it
> >probably would not be too hard to fix, because you can just look at
> >another filesystem that has proper locking.
> >  
> >
> Wrong. ;-)  Balancing makes it way hard.  Use reiser4.  That has very 
> sophisticated locking that pushes the research envelope, if you want to 
> read code to learn about locking.....
> 

OK, I will give it a try.  Are any of the reiser3 latency issues
reported in the voluntary preemption thread addressed in reiser4?

Lee 

