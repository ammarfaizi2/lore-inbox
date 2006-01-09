Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWAIE3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWAIE3I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWAIE3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:29:08 -0500
Received: from hulk.jobsahead.com ([202.138.125.174]:44480 "EHLO
	hulk.jobsahead.com") by vger.kernel.org with ESMTP id S1751250AbWAIE3H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:29:07 -0500
Subject: Re: High load
From: Aniruddh Singh <aps@jobsahead.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106214857.08d366f2.rdunlap@xenotime.net>
References: <1136454597.6016.7.camel@aps.monsterindia.noida>
	 <200601052100.45107.kernel@kolivas.org>
	 <1136550971.5557.2.camel@aps.monsterindia.noida>
	 <1136552226.2940.35.camel@laptopd505.fenrus.org>
	 <1136562410.5557.4.camel@aps.monsterindia.noida>
	 <1136569073.2940.54.camel@laptopd505.fenrus.org>
	 <1136612829.5557.6.camel@aps.monsterindia.noida>
	 <20060106214857.08d366f2.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Mon, 09 Jan 2006 10:05:05 +0530
Message-Id: <1136781305.5557.18.camel@aps.monsterindia.noida>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4.asl) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-06 at 21:48 -0800, Randy.Dunlap wrote:
> On Sat, 07 Jan 2006 11:17:09 +0530 Aniruddh Singh wrote:
> 
> >  
> > > > > for measuring IO performance, I'd recommend tiobench over hdparm any day
> > > > > ( http://tiobench.sf.net )
> > > > 
> > > > i will do it, can you please tell me why load goes high when i compile
> > > > kernel (10 and above)
> > > 
> > > thats really odd, unless you do a "make -j", in which case of course
> > > it's expected ;)
> > yes i always use make -j option ??
> 
> With or without a following integer?
make -j8, machine has 4 processor 
> 
> See 'make help':
>   -j [N], --jobs[=N]          Allow N jobs at once; infinite jobs with no arg.
> 
> so use make -j N to limit the number of makes/compiles etc.
> or use 'make -j' to go ballistic.
> 
> ---
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Regards
Aniruddh Singh
System Administrator
Monster.com India Pvt. Ltd.
FC 23, Block B, 1st Floor, Sector 16A
Film City Noida 201301 U.P.


