Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267748AbUHaKcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267748AbUHaKcI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 06:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267749AbUHaKcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 06:32:08 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:34989 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267748AbUHaKbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 06:31:47 -0400
Date: Tue, 31 Aug 2004 12:29:55 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: Jay Lan <jlan@sgi.com>, Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar =?iso-8859-1?Q?Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040831102955.GA3540@frec.bull.fr>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <20040827054218.GA4142@frec.bull.fr> <412F9197.4030806@sgi.com> <20040831090647.GA3441@frec.bull.fr>
Mime-Version: 1.0
In-Reply-To: <20040831090647.GA3441@frec.bull.fr>
User-Agent: Mutt/1.5.6+20040722i
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/08/2004 12:35:19,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 31/08/2004 12:35:25,
	Serialize complete at 31/08/2004 12:35:25
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2004 at 11:06:47AM +0200, Guillaume Thouvenin wrote:
> On Fri, Aug 27, 2004 at 12:55:03PM -0700, Jay Lan wrote:
> > Please visit http://oss.sgi.com/projects/pagg/
> > The page has been updated to provide information on a per job
> > accounting project called 'job' based on PAGG.
> > 
> > There is one userspace rpm and one kernel  module for job.
> > This may provide what you are looking for. It is a mature product
> > as well. I am sure Limin(job) and Erik(pagg) would appreciate any
> > input you can provide to make 'job' more useful.
> 
>   I have a question about job. If I understand how it works, you can not
> add a process in a job. I mean when you start a session, a container is 
> created and it's the only way to create it. If I'm right, I think that it 
> could be interesting to add a process using ioctl and /proc interface.

I think that I'm not very clear. You can add a process to a container
using the /proc/csa interface but it seems that currently this feature
is not available with job-1.2.1 package. Therefore, maybe we can add a
command called jattach that will attach a process to a given jid...

Best,
Guillaume
