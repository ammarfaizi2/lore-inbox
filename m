Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263835AbTDIVhh (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263838AbTDIVhh (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 17:37:37 -0400
Received: from [12.47.58.221] ([12.47.58.221]:13684 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263835AbTDIVhf (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 17:37:35 -0400
Date: Wed, 9 Apr 2003 14:49:30 -0700
From: Andrew Morton <akpm@digeo.com>
To: Steven Cole <elenstev@mesatop.com>
Cc: felipe_alfaro@linuxmail.org, linux-kernel@vger.kernel.org
Subject: Re: 2.5.67, 2.5-bk lock up with RH 9 and graphical log out.
Message-Id: <20030409144930.5c72d732.akpm@digeo.com>
In-Reply-To: <1049924199.24466.51.camel@spc9.esa.lanl.gov>
References: <1049904293.24463.25.camel@spc9.esa.lanl.gov>
	<1049921014.592.0.camel@teapot.felipe-alfaro.com>
	<1049922707.24466.41.camel@spc9.esa.lanl.gov>
	<1049924199.24466.51.camel@spc9.esa.lanl.gov>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Apr 2003 21:49:08.0846 (UTC) FILETIME=[D96978E0:01C2FEE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
> On Wed, 2003-04-09 at 15:11, Steven Cole wrote:
> 
> > I also tried 2.5.67-ac1 which behaves the same as above, and
> > 2.5.67-mm1 which does not hang, but reboots.  Adding akpm to
> > the cc-list since -mm1 behaves a little differently than the rest.
> > 
> > I replaced id:5:initdefault: with id:3:initdefault: in /etc/inittab
> > and that made the lockups go away with 2.5.67-[bk,ac1,mm1].  
> 
> Sorry, that last statement was a little vague.  I usually start X
> with "startx", and that works fine with everything.  Hitting "Log Out"
> kills X and gets me back to run level 3.  However, if I do a
> /sbin/init 5, log in with the graphical login and then hit "Log Out",
> the 2.5.67-[bk,ac1] kernels lock up and -mm1 reboots.

Something seems to have gone bad with AGP and/or DRM and/or radeon lately.

Try disabling AGP and/or DRM in config.

