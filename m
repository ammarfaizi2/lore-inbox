Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWCIEyz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWCIEyz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 23:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCIEyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 23:54:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31171 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751096AbWCIEyy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 23:54:54 -0500
Subject: Re: [PATCH] mm: yield during swap prefetching
From: Lee Revell <rlrevell@joe-job.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Zan Lynx <zlynx@acm.org>,
       =?ISO-8859-1?Q?Andr=E9?= Goddard Rosa <andre.goddard@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, ck@vds.kolivas.org
In-Reply-To: <cone.1141877326.889550.27403.501@kolivas.org>
References: <200603081013.44678.kernel@kolivas.org>
	 <200603081322.02306.kernel@kolivas.org> <1141784834.767.134.camel@mindpipe>
	 <200603081330.56548.kernel@kolivas.org>
	 <b8bf37780603071852r6bf3821fr7610597a54ad305b@mail.gmail.com>
	 <cone.1141787137.882268.19235.501@kolivas.org>
	 <1141852064.21958.28.camel@localhost>
	 <cone.1141858802.179786.26372.501@kolivas.org>
	 <1141861694.21958.66.camel@localhost>
	 <cone.1141862870.463023.26372.501@kolivas.org>
	 <1141874012.21958.138.camel@localhost>
	 <cone.1141877326.889550.27403.501@kolivas.org>
Content-Type: text/plain
Date: Wed, 08 Mar 2006 23:54:51 -0500
Message-Id: <1141880092.13319.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:08 +1100, Con Kolivas wrote:
> > Games do have real-time requirements.
> > The OS guessing about real-time priorities will sometimes get it wrong.
> > Guessing task priority is worse than being told and knowing for sure.
> > Games should, in an ideal world, be using real-time OS scheduling.
> > Games would work better using real-time OS scheduling.
> 
> At the risk of  being repetitive to the point of tiresome, my point is that 
> there are no real time requirements in games. You're assuming that 
> everything will be better if we assume that there are rt requirements and 
> that we're simulating pseudo real time conditions currently. That's just not 
> the case and never has been. That's why it has worked fine for so long. 

I think you are talking past each other, and are both right - Con is
saying games don't need realtime scheduling (SCHED_FIFO, low nice value,
whatever) to function correctly (true), while Zan is saying that games
have RT constraints in that they must react as fast as possible to user
input (also true).

Anyway, this is getting OT, I wish I had not raised this issue in this
thread.

Lee

