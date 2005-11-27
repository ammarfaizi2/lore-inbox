Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751014AbVK0TyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbVK0TyN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 14:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbVK0TyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 14:54:13 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:33705 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750834AbVK0TyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 14:54:12 -0500
Subject: Re: [PATCH 00/19] Adaptive read-ahead V8
From: Lee Revell <rlrevell@joe-job.com>
To: Mark van der Made <streamlife@gmail.com>
Cc: Diego Calleja <diegocg@gmail.com>, Wu Fengguang <wfg@mail.ustc.edu.cn>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <fb1c016d0511261503w534d2dc2k9a350fc9bca844d6@mail.gmail.com>
References: <20051125151210.993109000@localhost.localdomain>
	 <20051125164317.c42c0639.diegocg@gmail.com>
	 <1132947083.20390.53.camel@mindpipe>
	 <fb1c016d0511261503w534d2dc2k9a350fc9bca844d6@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 27 Nov 2005 14:54:00 -0500
Message-Id: <1133121240.19202.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-11-27 at 00:03 +0100, Mark van der Made wrote:
> On 11/25/05, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2005-11-25 at 16:43 +0100, Diego Calleja wrote:
> > > Recently, a openoffice hacker wrote in his blog that the kernel was
> > > culprit of applications not starting as fast as in other systems.
> >
> > Useless without a link ;-)
> >
> I think Diego refers to Michael Meeks blog:
> http://www.gnome.org/~michael/activity.html#2005-11-04
> Michael Meek also speaks about kernel issues in an interview in Linux
> Format 72 (nov 2005).
> 

This link tells a much more interesting story:

http://www.gnome.org/~lcolitti/gnome-startup/analysis/

Seems like most of the problems are in userspace at the application
level.

Maybe the excessive seeking when loading libraries could be solved by
physically rearranging the libraries on disk so that the "hot paths"
don't induce as many seeks.

Lee

