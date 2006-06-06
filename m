Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWFFJRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWFFJRG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 05:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWFFJRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 05:17:06 -0400
Received: from mail14.syd.optusnet.com.au ([211.29.132.195]:39830 "EHLO
	mail14.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750977AbWFFJRF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 05:17:05 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [RFC 3/5] sched: Add CPU rate hard caps
Date: Tue, 6 Jun 2006 19:13:33 +1000
User-Agent: KMail/1.9.3
Cc: Kirill Korotaev <dev@sw.ru>, Sam Vilain <sam@vilain.net>,
       Kirill Korotaev <dev@openvz.org>,
       Peter Williams <pwil3058@bigpond.net.au>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, Srivatsa <vatsa@in.ibm.com>,
       ckrm-tech@lists.sourceforge.net, balbir@in.ibm.com,
       Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
       Kingsley Cheung <kingsley@aurema.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, Rene Herman <rene.herman@keyaccess.nl>
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest> <4484ABF9.50503@vilain.net> <44853BCA.4010009@sw.ru>
In-Reply-To: <44853BCA.4010009@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606061913.35340.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 06 June 2006 18:24, Kirill Korotaev wrote:
> >>I'm sorry, but nice never looked "nice" to me.
> >>Have you ever tried to "nice" apache server which spawns 500
> >>processes/threads on a loaded machine?
> >>With nice you _can't_ impose limits or priority on the whole "apache".
> >>The more apaches you have the more useless their priorites and nices
> >> are...
> >
> > Yes but interactive admin processes will still get a large bonus
> > relative to the apache processes so you can still log in and kill the
> > apache storm off even with very large loads.
>
> And how do you plan to manage it: to log in every time when apache works
> too much and kill processes? The managabiliy of such solutions sucks..

What a strange discussion. I simply impose limits on processes and connections 
on my grossly underpowered server.

/me shrugs

-- 
-ck
