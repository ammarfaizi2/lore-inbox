Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUJEGlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUJEGlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268848AbUJEGlM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 02:41:12 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59859 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268846AbUJEGlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 02:41:09 -0400
Date: Tue, 5 Oct 2004 02:38:38 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Rui Nuno Capela <rncbc@rncbc.org>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>, "K.R. Foley" <kr@cybsft.com>,
       thewade <pdman@aproximation.org>, Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc3-mm1-S9
In-Reply-To: <32786.192.168.1.5.1096939184.squirrel@192.168.1.5>
Message-ID: <Pine.LNX.4.58.0410050233190.1655@devserv.devel.redhat.com>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com> 
   <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>   
 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>   
 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>   
 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>   
 <20041004215315.GA17707@elte.hu> <32786.192.168.1.5.1096939184.squirrel@192.168.1.5>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Oct 2004, Rui Nuno Capela wrote:

> Ingo wrote:
> >
> > i've released the -S9 VP patch:
> > http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-S9
> >
> 
> Me again, we bad humor :(
> 
> My SMP/HT box is (again) terribly in that uglyness of being quite
> unfriendly to -mm1, -mm2, and indirectly to -S8 and -S9 labeled kernels.

could you apply this patch first:

 http://redhat.com/~mingo/voluntary-preempt/zaphod-undo-2.6.9-rc3-mm2-A0

to get back to the original scheduler. Can you still see problems with
this one applied? If yes then please try to debug it a bit more.

	Ingo
