Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268864AbUJEHEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268864AbUJEHEd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 03:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268868AbUJEHEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 03:04:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47837 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268864AbUJEHE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 03:04:27 -0400
Date: Tue, 5 Oct 2004 03:02:05 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: linux-kernel@vger.kernel.org
cc: mingo@elte.hu, Lee Revell <rlrevell@joe-job.com>,
       "K.R. Foley" <kr@cybsft.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Florian Schmidt <mista.tapas@gmx.net>
Subject: [patch] voluntary-preempt-2.6.9-rc3-mm2-T0
In-Reply-To: <20041004215315.GA17707@elte.hu>
Message-ID: <Pine.LNX.4.58.0410050257400.5641@devserv.devel.redhat.com>
References: <20040919122618.GA24982@elte.hu> <414F8CFB.3030901@cybsft.com>
 <20040921071854.GA7604@elte.hu> <20040921074426.GA10477@elte.hu>
 <20040922103340.GA9683@elte.hu> <20040923122838.GA9252@elte.hu>
 <20040923211206.GA2366@elte.hu> <20040924074416.GA17924@elte.hu>
 <20040928000516.GA3096@elte.hu> <20041003210926.GA1267@elte.hu>
 <20041004215315.GA17707@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i've released the -T0 VP patch:

  http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc3-mm2-T0

Changes since -T0:

 - fix preempt-timing facility (reported by Florian Schmidt)

 - fix !4K stack compilation breakage (reported by Lee Revell)

 - revert experimental scheduler stuff from -mm. (Rui, does this fix your 
   problems?)

note that sw-suspend and x64+LATENCY_TRACE is still broken.

	Ingo
