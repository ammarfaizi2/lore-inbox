Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269040AbUJQDo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269040AbUJQDo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269048AbUJQDo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:44:56 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16596 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269049AbUJQDoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:44:08 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Pavel Machek <pavel@ucw.cz>, M <mru@mru.ath.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1097979705.13269.9.camel@localhost.localdomain>
References: <41650CAF.1040901@unimail.com.au>
	 <20041007103210.GA32260@atrey.karlin.mff.cuni.cz>
	 <yw1x7jq2n6k3.fsf@mru.ath.cx>  <20041007143245.GA1698@openzaurus.ucw.cz>
	 <1097956343.2148.17.camel@krustophenia.net>
	 <1097963167.13226.4.camel@localhost.localdomain>
	 <1097976283.2148.34.camel@krustophenia.net>
	 <1097979705.13269.9.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1097984002.2148.44.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 16 Oct 2004 23:33:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-16 at 22:21, Alan Cox wrote:
> On Sul, 2004-10-17 at 02:24, Lee Revell wrote:
> > > And heavily reduced accuracy on a lot of laptops where 1000Hz
> > > is enough to make the clock slide every time the battery state is
> > > queried or an SMM event triggers.
> > Wouldn't such a laptop be horribly broken?  1ms is a LONG time to
> > disable interrupts.  That's millions of CPU cycles...
> 
> Yes, and most laptops have this problem. They use SMM traps to talk to
> the battery including huge delay loops and during those SMM traps no
> interrupt code runs.
> 

Ugh!  I was under the impression that mostly older machines had this
problem and it was a minority of laptops.  I could not find a lot of 
info on SMM  - several of the links I found were DDJ "Undocumented
Corner" articles.

Anyway this explains probably half the weird bug reports on the linux
audio user list.

Lee

