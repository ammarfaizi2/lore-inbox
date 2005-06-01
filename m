Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261231AbVFASum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261231AbVFASum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261230AbVFAStn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:49:43 -0400
Received: from mout.perfora.net ([217.160.230.41]:44281 "EHLO mout.perfora.net")
	by vger.kernel.org with ESMTP id S261544AbVFASeH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:34:07 -0400
Subject: Re: Tyan Opteron boards and problems with parallel ports (badpmd)
From: Christopher Warner <chris@servertogo.com>
To: "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Christopher Warner <cwarner@kernelcode.com>,
       "Peter J. Stieber" <developer@toyon.com>, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>, admin@list.net.ru
In-Reply-To: <200506011322.42782.rathamahata@ehouse.ru>
References: <3174569B9743D511922F00A0C943142309F815A6@TYANWEB>
	 <1117190965.13932.36.camel@sabrina>
	 <200506011316.29771.rathamahata@ehouse.ru>
	 <200506011322.42782.rathamahata@ehouse.ru>
Content-Type: text/plain
Date: Wed, 01 Jun 2005 09:51:33 -0400
Message-Id: <1117633893.22578.1.camel@sabrina>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-Provags-ID: perfora.net abuse@perfora.net login:d2cbd72fb1ab4860f78cabc62f71ec31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > > What we need is to try and single out the variables that are causing the
> > > badpmd's. Also the more people who report badpmd's with Andi Kleen's
> > > intial patch the better. Especially on different archs; would also be
> > > good. So far from lkml i'm only seeing Tyan S28* boards as of recent.
> > We have run into different problem (for our different from S28*arch)
> > for the box which had had badpmd issues with v2.6.11 (see:
> >     http://seclists.org/lists/linux-kernel/2005/May/6369.html)
> Oops, wrong link, right one is: http://lkml.org/lkml/2005/3/11/42
> 
> > 
> > with 2.6.12-rc5 we are always getting dozens of user-space segfaults:
> > 
> > grep[25377]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffffb13cb8 error4
> > grep[29940]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffff913428 error4
> > sed[5849] general protection rip:40bac5 rsp:7fffffb231d0 error:0
> > sed[27437] general protection rip:40bac5 rsp:7ffffff248c0 error:0
> > sed[27473] general protection rip:40bac5 rsp:7fffff923740 error:0
> > sed[27472] general protection rip:40bac5 rsp:7fffff923740 error:0
> > sed[28434] general protection rip:406965 rsp:7fffffb23f10 error:0
> > grep[32583]: segfault at 0000000000014aa0 rip 00002aaaaad37130 rsp 00007fffffd13b58 error4
> > sed[9074] general protection rip:40bac5 rsp:7fffffb248a0 error:0
> > sed[9546] general protection rip:406965 rsp:7fffffb23cc0 error:0
> > sed[4331] general protection rip:40bac5 rsp:7fffff922fb0 error:0
> > sed[17906] general protection rip:40bac5 rsp:7fffffd24b30 error:0
> > sed[17934] general protection rip:40bac5 rsp:7fffffd243a0 error:0
> > sed[19555] general protection rip:40bac5 rsp:7fffff924ad0 error:0
> > sed[20453] general protection rip:40bac5 rsp:7ffffff23010 error:0
> > 
> > during the build of mysql.
> > 
> > There also was an oops with v2.6.12-rc3 for the same box:
> > http://seclists.org/lists/linux-kernel/2005/May/6369.html
> > 
> > Box passed two iterations of memtest86 (unfortunately this
> > is a production box, so we can't wait for days).
> > 
> 

Do you have any mobo/chipset information and are those amd64's opterons?

Thanks,
Christopher Warner

