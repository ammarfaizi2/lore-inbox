Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422835AbWAMTNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWAMTNy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422836AbWAMTNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:13:53 -0500
Received: from smtp5.wanadoo.fr ([193.252.22.26]:24794 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1422835AbWAMTNw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:13:52 -0500
X-ME-UUID: 20060113191351925.E1EB61C01632@mwinf0507.wanadoo.fr
Subject: Re: Dual core Athlons and unsynced TSCs
From: Xavier Bestel <xavier.bestel@free.fr>
To: Sven-Thorsten Dietrich <sven@mvista.com>
Cc: thockin@hockin.org, Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1137178574.2536.13.camel@localhost.localdomain>
References: <1137104260.2370.85.camel@mindpipe>
	 <20060113180620.GA14382@hockin.org> <1137175117.15108.18.camel@mindpipe>
	 <20060113181631.GA15366@hockin.org> <1137175792.15108.26.camel@mindpipe>
	 <20060113185533.GA18301@hockin.org>
	 <1137178574.2536.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15
Date: Fri, 13 Jan 2006 20:13:57 +0100
Message-Id: <1137179637.9366.1.camel@bip.parateam.prv>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 13 janvier 2006 à 10:56 -0800, Sven-Thorsten Dietrich a
écrit :
> On Fri, 2006-01-13 at 10:55 -0800, thockin@hockin.org wrote:
> > On Fri, Jan 13, 2006 at 01:09:51PM -0500, Lee Revell wrote:
> > > > Some apps/users need higher resolution and lower overhead that only rdtsc
> > > > can offer currently.
> > > 
> > > But obviously if the TSC gives wildly inaccurate results, it cannot be
> > > used no matter how low the overhead.
> > 
> > unless we can re-sync the TSCs often enough that apps don't notice.
> > 
> 
> You'd have to quantify that somehow, in terms of the max drift rate
> (ppm), and the max resolution available (< tsc frequency).  
> 
> Either that, or track an offset, and use one TSC as truth, and update
> the correction factor for the other TSCs as often as needed, maybe?

As often as needed being each time a thread changes CPU ?


