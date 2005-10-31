Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVJaUIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVJaUIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 15:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVJaUIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 15:08:09 -0500
Received: from silver.veritas.com ([143.127.12.111]:19788 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S964817AbVJaUII
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 15:08:08 -0500
Date: Mon, 31 Oct 2005 20:07:07 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Ingo Molnar <mingo@elte.hu>
cc: "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       tytso@us.ibm.com, sripathi@in.ibm.com, dipankar@in.ibm.com,
       oleg@tv-sign.ru
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
In-Reply-To: <20051031195425.GA14806@elte.hu>
Message-ID: <Pine.LNX.4.61.0510312004460.10705@goblin.wat.veritas.com>
References: <20051031174416.GA2762@us.ibm.com>
 <Pine.LNX.4.61.0510311802550.9631@goblin.wat.veritas.com> <20051031195425.GA14806@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 Oct 2005 20:08:08.0263 (UTC) FILETIME=[CFABE570:01C5DE56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Oct 2005, Ingo Molnar wrote:
> * Hugh Dickins <hugh@veritas.com> wrote:
> > 
> > Not my area at all, but this looks really dodgy to me, Paul:
> > could you explain it further?
> 
> the patch below (included in the -rt tree) is the prerequisite. That's 
> what Paul's "requires RCU on task_struct" comment refers to.

Thanks, Ingo: Sorry, Paul: I missed that it was an -rt patch: Ignore me.

Hugh
