Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWBZCg6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWBZCg6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 21:36:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWBZCg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 21:36:58 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2180 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751182AbWBZCg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 21:36:57 -0500
Subject: Re: old radeon latency problem still unfixed?
From: Lee Revell <rlrevell@joe-job.com>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <1140921200.12674.29.camel@cmn3.stanford.edu>
References: <1140917787.24141.78.camel@mindpipe>
	 <1140921200.12674.29.camel@cmn3.stanford.edu>
Content-Type: text/plain
Date: Sat, 25 Feb 2006 21:36:55 -0500
Message-Id: <1140921415.24141.92.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-25 at 18:33 -0800, Fernando Lopez-Lezcano wrote:
> On Sat, 2006-02-25 at 20:36 -0500, Lee Revell wrote:
> > Users report that this patch:
> > 
> > https://www.redhat.com/archives/fedora-devel-list/2004-June/msg00072.html
> > 
> > is still needed to eliminate audio underruns for Radeon users.
> > 
> > Any news on this?
> 
> You mean on the plain vanilla stable kernel tree? Users running what?
> 

Presumably.

> I'm using 2.6.15-rt18 currently on radeon machines (9250 chipset) with
> no problems that I can see. 

We don't want to require the -rt kernel to use JACK at modest latencies,
that's like killing a fly with a gun.

Lee

