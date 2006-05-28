Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWE1OmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWE1OmG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 10:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWE1OmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 10:42:05 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:34136 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750770AbWE1OmE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 10:42:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=C94cHmtLoq0iwQihMvwaQc4WENIN+wGefqxlRUqxD396K+dNkjoadRpaiMzZ3lC7MRks+R6OQUDx4wsp/xFu6XEOBg5xy75B5U0ipropK/7uUNJzNtaLhMgXI58pEvQnYjB3m4wQpoPXtwPbgOiChqPtNfcaJG5vxwV78NGjoa8=
Message-ID: <661de9470605280742o70fb6fc9g34ead234d377a1e0@mail.gmail.com>
Date: Sun, 28 May 2006 20:12:03 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Peter Williams" <pwil3058@bigpond.net.au>
Subject: Re: [RFC 2/5] sched: Add CPU rate soft caps
Cc: "Mike Galbraith" <efault@gmx.de>, "Con Kolivas" <kernel@kolivas.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Kingsley Cheung" <kingsley@aurema.com>, "Ingo Molnar" <mingo@elte.hu>,
       "Rene Herman" <rene.herman@keyaccess.nl>
In-Reply-To: <4479A71C.4060604@bigpond.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060526042021.2886.4957.sendpatchset@heathwren.pw.nest>
	 <20060526042041.2886.69840.sendpatchset@heathwren.pw.nest>
	 <661de9470605262331w2e2258a7r41e2aab10895955f@mail.gmail.com>
	 <4477F9DC.8090107@bigpond.net.au> <4478EA9D.4030201@bigpond.net.au>
	 <661de9470605280038l40e53357ka3043dabd95de5fc@mail.gmail.com>
	 <4479A71C.4060604@bigpond.net.au>
X-Google-Sender-Auth: 4da3cafcb9cd66a1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/06, Peter Williams <pwil3058@bigpond.net.au> wrote:
<snip>

> >
> > That behaviour would be fair.
>
> Caps aren't about being fair.  In fact, giving a task a cap is an
> explicit instruction to the scheduler that the task should be treated
> unfairly in some circumstances (namely when it's exceeding that cap).
>
> Similarly, the interactive bonus mechanism is not about fairness either.
>   It's about giving tasks that are thought to be interactive an unfair
> advantage so that the user experiences good responsiveness.
>

I understand that, I was talking about fairness between capped tasks
and what might be considered fair or intutive between capped tasks and
regular tasks. Of course, the last point is debatable ;)

Balbir
