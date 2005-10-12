Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbVJLREM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbVJLREM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVJLREL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:04:11 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:46281 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932433AbVJLREK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:04:10 -0400
Date: Wed, 12 Oct 2005 13:03:40 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Lee Revell <rlrevell@joe-job.com>
cc: Mark Knecht <markknecht@gmail.com>, Ingo Molnar <mingo@elte.hu>,
       Daniel Walker <dwalker@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: Latency data - 2.6.14-rc3-rt13
In-Reply-To: <1129133902.10599.10.camel@mindpipe>
Message-ID: <Pine.LNX.4.58.0510121301460.9258@localhost.localdomain>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com> 
 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com> 
 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net> 
 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com> 
 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com> 
 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com> 
 <20051011111700.GA15892@elte.hu>  <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
  <1129075368.7094.3.camel@mindpipe>  <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
  <1129080062.7094.7.camel@mindpipe>  <Pine.LNX.4.58.0510120233300.5830@localhost.localdomain>
 <1129133902.10599.10.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 12 Oct 2005, Lee Revell wrote:

>
> I believe this is the expected behavior under 2.6 unless you
> set /proc/sys/vm/swappiness to 0.  If an app allocates memory and then
> never touches it then those pages will eventually be swapped out to make
> room for hot ones.
>

OK, thanks for the info.  I guess my apps don't allocate enough memory to
be eventually swapped out (I obviously run 2.6).  Or those apps use the
memory that it allocates often.

Whatever..

-- Steve

