Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263381AbTE3Hz7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 03:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263380AbTE3Hz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 03:55:58 -0400
Received: from mail.ithnet.com ([217.64.64.8]:47881 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S263375AbTE3Hz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 03:55:56 -0400
Date: Fri, 30 May 2003 10:09:00 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: marcelo@conectiva.com.br
Cc: m.c.p@wolk-project.de, willy@w.ods.org, gibbs@scsiguy.com,
       linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes
Message-Id: <20030530100900.768ceeef.skraw@ithnet.com>
In-Reply-To: <20030526164404.GA11381@alpha.home.local>
References: <Pine.LNX.4.55L.0305071716050.17793@freak.distro.conectiva>
	<20030524111608.GA4599@alpha.home.local>
	<20030525125811.68430bda.skraw@ithnet.com>
	<200305251447.34027.m.c.p@wolk-project.de>
	<20030526170058.105f0b9f.skraw@ithnet.com>
	<20030526164404.GA11381@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcelo,

I tried plain rc6 now and have to tell you it does not survive a single day of
my usual tests. It freezes during tar from 3ware-driven IDE to aic-driven SDLT.
This is identical to all previous rc (and some pre) releases of 2.4.21. So far
I can tell you that the only thing that has recently cured this problem is
replacing the aic-driver with latest of justins' releases.
As plain rc6 does definitely not work I will now switch over to
rc6+aic-20030523. Remember that rc3+aic-20030523 already worked quite ok (4
days test survived).

My personal opinion is a known-to-be-broken 2.4.21 should not be released, as a
lot of people only try/use the releases and therefore an immediately released
2.4.22-pre1 with justins driver will not be a good solution.

Regards,
Stephan
