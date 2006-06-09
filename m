Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbWFIUE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbWFIUE2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 16:04:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFIUE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 16:04:28 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:24513 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1030238AbWFIUE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 16:04:27 -0400
Subject: Re: Idea about a disc backed ram filesystem
From: Lee Revell <rlrevell@joe-job.com>
To: Matheus Izvekov <mizvekov@gmail.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Sascha Nitsch <Sash_lkl@linuxhowtos.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <305c16960606091243h10638b2ayb7f1066bb839e496@mail.gmail.com>
References: <mizvekov@gmail.com>
	 <305c16960606082159v2dc588abo6359d87173327c83@mail.gmail.com>
	 <200606091343.k59DhC1f004434@laptop11.inf.utfsm.cl>
	 <305c16960606090807g6372b69dy3167b0e191b2c113@mail.gmail.com>
	 <1149878633.3894.224.camel@mindpipe>
	 <305c16960606091227w7e62003bhef576fb07d0aa95@mail.gmail.com>
	 <1149881504.3894.250.camel@mindpipe>
	 <305c16960606091243h10638b2ayb7f1066bb839e496@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 09 Jun 2006 16:03:22 -0400
Message-Id: <1149883402.3894.265.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 16:43 -0300, Matheus Izvekov wrote:
> On 6/9/06, Lee Revell <rlrevell@joe-job.com> wrote:
> > On Fri, 2006-06-09 at 16:27 -0300, Matheus Izvekov wrote:
> > > Sorry, i took a look at the code which handles this and swappiness = 0
> > > doesnt seem to imply that process memory will never be swapped out.
> > >
> >
> > OK, then use mlockall().
> >
> > Lee
> >
> >
> 
> If i make init mlockall, would all child processes be mlocked too?

No.

> If not, using this to enforce a system wide policy seems a bit hacky
> and non trivial.
> 

Well, what you are trying to do seems hacky.  What real world problem
are you trying to solve that setting swappiness to 0 is not sufficient
for?

Lee



