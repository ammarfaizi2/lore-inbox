Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269503AbUHZTtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269503AbUHZTtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 15:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUHZTq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:46:29 -0400
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:26348 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S269501AbUHZTp2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:45:28 -0400
Date: Thu, 26 Aug 2004 11:44:20 -0800 (AKDT)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Jay Lan <jlan@engr.sgi.com>
cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       =?X-UNKNOWN?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <412E2B6B.80904@engr.sgi.com>
Message-ID: <Pine.LNX.4.58.0408261130440.22750@bifrost.nevaeh-linux.org>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <412E2B6B.80904@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -1.971 () AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, Jay Lan wrote:

> The reason for breaking up one CSA patch into four patches was
> so that the only CSA (http://oss.sgi.com/projects/csa/) specific
> thing is the csa_module. My intention is to improve the system
> accounting data collection and make the data available to any
> clients that can use the data. The three areas of accounting
> data we try to improve are io, mm, and per-process area.
>
> As Tim said the problem of BSD accounting was that it has been
> inactive for a long time. I do not mind incoporating the
> three accounting data collection patches i submitted into BSD or
> others as long as the data made available to modules that plan
> to make use of the data. :)

All right, I'm going to shut up now.  I had no idea that SGI had gone behind
my back and started porting CSA to Linux.  :-P  Before I shut up, though, as a
user of these tools I'd vote for a unified data collection method, as
suggested above.  There has to be at least five of us who have volunteered at
one point or another to help make the GNU utilities conform.  That should make
everyone happy.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
