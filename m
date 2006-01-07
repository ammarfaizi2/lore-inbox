Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030475AbWAGFtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030475AbWAGFtE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbWAGFtE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:49:04 -0500
Received: from xenotime.net ([66.160.160.81]:52929 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030480AbWAGFtD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:49:03 -0500
Date: Fri, 6 Jan 2006 21:48:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Aniruddh Singh <aps@jobsahead.com>
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: High load
Message-Id: <20060106214857.08d366f2.rdunlap@xenotime.net>
In-Reply-To: <1136612829.5557.6.camel@aps.monsterindia.noida>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	<200601052100.45107.kernel@kolivas.org>
	<1136550971.5557.2.camel@aps.monsterindia.noida>
	<1136552226.2940.35.camel@laptopd505.fenrus.org>
	<1136562410.5557.4.camel@aps.monsterindia.noida>
	<1136569073.2940.54.camel@laptopd505.fenrus.org>
	<1136612829.5557.6.camel@aps.monsterindia.noida>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Jan 2006 11:17:09 +0530 Aniruddh Singh wrote:

>  
> > > > for measuring IO performance, I'd recommend tiobench over hdparm any day
> > > > ( http://tiobench.sf.net )
> > > 
> > > i will do it, can you please tell me why load goes high when i compile
> > > kernel (10 and above)
> > 
> > thats really odd, unless you do a "make -j", in which case of course
> > it's expected ;)
> yes i always use make -j option ??

With or without a following integer?

See 'make help':
  -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.

so use make -j N to limit the number of makes/compiles etc.
or use 'make -j' to go ballistic.

---
~Randy
