Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263394AbTE3IGj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 04:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTE3IGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 04:06:39 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:41480 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263365AbTE3IGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 04:06:37 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Stephan von Krawczynski <skraw@ithnet.com>, marcelo@conectiva.com.br
Subject: Re: Undo aic7xxx changes
Date: Fri, 30 May 2003 10:19:25 +0200
User-Agent: KMail/1.5.2
Cc: willy@w.ods.org, gibbs@scsiguy.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva> <20030526164404.GA11381@alpha.home.local> <20030530100900.768ceeef.skraw@ithnet.com>
In-Reply-To: <20030530100900.768ceeef.skraw@ithnet.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305301018.14970.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 May 2003 10:09, Stephan von Krawczynski wrote:

Hi Stephan,

> I tried plain rc6 now and have to tell you it does not survive a single day
> of my usual tests. It freezes during tar from 3ware-driven IDE to
> aic-driven SDLT. This is identical to all previous rc (and some pre)
> releases of 2.4.21. So far I can tell you that the only thing that has
> recently cured this problem is replacing the aic-driver with latest of
> justins' releases.
> As plain rc6 does definitely not work I will now switch over to
> rc6+aic-20030523. Remember that rc3+aic-20030523 already worked quite ok (4
> days test survived).
same experience on my boxen (quite much with AIC)

> My personal opinion is a known-to-be-broken 2.4.21 should not be released,
> as a lot of people only try/use the releases and therefore an immediately
> released 2.4.22-pre1 with justins driver will not be a good solution.
ACK!

Maybe we should disable AIC Config option and instead add a comment like:

comment 'For AICXXXX, please go to http://people.freebsd.org/~gibbs/linux/'
comment 'and download the latest tar.gz and unpack these drivers!'
comment 'After unpacking, enable Config.in option in drivers/scsi/Config.in'

*scnr* ;)

ciao, Marc

